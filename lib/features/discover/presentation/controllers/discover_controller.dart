import 'package:anipick/core/error/failure.dart';
import 'package:anipick/core/error/ui_error.dart';
import 'package:anipick/features/auth/provider/auth_controller.dart';
import 'package:anipick/features/discover/domain/usecases/get_season_works.dart';
import 'package:anipick/features/discover/presentation/states/discover_ui_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discover_controller.g.dart';

/// Discover画面の状態を管理
@riverpod
final class DiscoverController extends _$DiscoverController {
  @override
  Future<DiscoverUiState> build() async {
    final auth = await ref.watch(authControllerProvider.future);
    final token = auth.accessToken?.value;
    if (token == null || token.isEmpty) {
      throw _mapFailureToUiError(const UnauthorizedFailure());
    }

    final currentSeason = _currentSeasonName(DateTime.now());

    final usecase = ref.read(getSeasonWorksProvider);

    final (currentWorks, currentFailure) = await usecase(
      season: currentSeason,
      accessToken: token,
    );

    if (currentFailure != null || currentWorks == null) {
      throw _mapFailureToUiError(currentFailure ?? const UnexpectedFailure());
    }

    final shuffledCurrentWorks = [...currentWorks]..shuffle();
    final recommended = shuffledCurrentWorks.take(5).toList();
    final currentTrending = shuffledCurrentWorks.skip(5).take(20).toList();

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

  UiError _mapFailureToUiError(Failure failure) {
    return switch (failure) {
      NetworkFailure() => const UiError(message: '通信に失敗しました'),
      UnauthorizedFailure() => const UiError(message: '認証に失敗しました'),
      UnexpectedFailure() => const UiError(message: '予期しないエラーが発生しました'),
    };
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
