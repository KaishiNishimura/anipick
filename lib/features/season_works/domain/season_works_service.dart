import 'package:anipick/features/season_works/domain/work.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'season_works_service.g.dart';

/// シーズン作品に関するドメインサービス
final class SeasonWorksService {
  /// 指定した数だけ前のシーズン名を取得（back=0 で現在シーズン）
  String getSeasonName(int back) {
    final seasonName = currentSeasonName(DateTime.now());
    if (back == 0) {
      return seasonName;
    }
    return previousSeasonName(seasonName, back);
  }

  /// 指定日時から現在のシーズン名を計算（例: "2024-winter"）
  String currentSeasonName(DateTime now) {
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

  /// 直近3シーズン分の名前を取得
  List<String> previousSeasonNames(String currentSeason) {
    return [
      previousSeasonName(currentSeason, 1),
      previousSeasonName(currentSeason, 2),
      previousSeasonName(currentSeason, 3),
    ];
  }

  /// 指定シーズンから back 分前のシーズン名を計算
  String previousSeasonName(String current, int back) {
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

  /// 作品リストからおすすめ5件とトレンド20件を抽出
  (List<Work>, List<Work>) getRecommendedAndCurrentTrendingWork(
    List<Work> currentWorks,
  ) {
    final shuffledCurrentWorks = [...currentWorks]..shuffle();
    final recommended = shuffledCurrentWorks.take(5).toList();
    final currentTrending = shuffledCurrentWorks.skip(5).take(20).toList();
    return (recommended, currentTrending);
  }
}

/// シーズン作品サービスを提供
@riverpod
SeasonWorksService seasonWorksService(Ref ref) {
  return SeasonWorksService();
}
