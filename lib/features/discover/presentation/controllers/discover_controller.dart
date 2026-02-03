import 'package:anipick/core/auth/auth_session_controller.dart';
import 'package:anipick/core/error/failure.dart';
import 'package:anipick/features/discover/di/providers.dart';
import 'package:anipick/features/discover/presentation/states/discover_ui_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Discoverで発生した失敗をラップする例外
final class DiscoverException implements Exception {
  /// 例外を作成
  const DiscoverException(this.failure);

  /// 失敗要因を保持
  final Failure failure;
}

/// Discover画面Controllerを提供
final AsyncNotifierProvider<DiscoverController, DiscoverUiState>
discoverControllerProvider =
    AsyncNotifierProvider.autoDispose<DiscoverController, DiscoverUiState>(
      DiscoverController.new,
    );

/// Discover画面の状態を管理
final class DiscoverController extends AsyncNotifier<DiscoverUiState> {
  @override
  Future<DiscoverUiState> build() async {
    final auth = await ref.watch(authSessionControllerProvider.future);
    final token = auth.accessToken?.value;
    if (token == null || token.isEmpty) {
      throw const DiscoverException(UnauthorizedFailure());
    }

    final currentSeason = _currentSeasonName(DateTime.now());

    final usecase = ref.read(getSeasonWorksProvider);

    final (currentWorks, currentFailure) = await usecase(
      season: currentSeason,
      accessToken: token,
    );

    if (currentFailure != null || currentWorks == null) {
      throw DiscoverException(currentFailure ?? const UnexpectedFailure());
    }

    final recommended = currentWorks.take(5).toList();
    final currentTrending = currentWorks.skip(5).take(20).toList();

    final previousSeasons = <String>[
      _previousSeasonName(currentSeason, 1),
      _previousSeasonName(currentSeason, 2),
      _previousSeasonName(currentSeason, 3),
    ];

    final previousSeasonTrending = <SeasonWorks>[];
    for (final season in previousSeasons) {
      final (works, failure) = await usecase(
        season: season,
        accessToken: token,
        perPage: 25,
      );
      if (failure != null || works == null) {
        continue;
      }
      final seasonText = works.isEmpty ? season : works.first.seasonNameText;
      previousSeasonTrending.add(
        SeasonWorks(
          season: season,
          seasonText: seasonText,
          works: works.take(15).toList(),
        ),
      );
    }

    final currentSeasonText = currentWorks.isEmpty
        ? currentSeason
        : currentWorks.first.seasonNameText;

    return DiscoverUiState(
      currentSeason: currentSeason,
      currentSeasonText: currentSeasonText,
      recommended: recommended,
      currentTrending: currentTrending,
      previousSeasonTrending: previousSeasonTrending,
    );
  }

  /// リロード
  Future<void> reload() async {
    state = const AsyncLoading<DiscoverUiState>();
    state = await AsyncValue.guard(build);
  }

  String _currentSeasonName(DateTime now) {
    final month = now.month;
    final year = now.year;

    final name = switch (month) {
      >= 1 && <= 3 => 'winter',
      >= 4 && <= 6 => 'spring',
      >= 7 && <= 9 => 'summer',
      _ => 'autumn',
    };

    return '$year-$name';
  }

  String _previousSeasonName(String current, int back) {
    final parts = current.split('-');
    if (parts.length != 2) return current;

    var year = int.tryParse(parts[0]) ?? DateTime.now().year;
    final season = parts[1];

    const order = <String>['winter', 'spring', 'summer', 'autumn'];
    var index = order.indexOf(season);
    if (index < 0) index = 0;

    for (var i = 0; i < back; i++) {
      index -= 1;
      if (index < 0) {
        index = order.length - 1;
        year -= 1;
      }
    }

    return '$year-${order[index]}';
  }
}
