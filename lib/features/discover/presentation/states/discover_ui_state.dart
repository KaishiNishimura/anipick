import 'package:anipick/features/discover/domain/entities/work.dart';

/// Discover画面のUI状態
final class DiscoverUiState {
  /// UI状態を作成
  const DiscoverUiState({
    required this.currentSeason,
    required this.currentSeasonText,
    required this.recommended,
    required this.currentTrending,
    required this.previousSeasonTrending,
  });

  /// 今期のシーズン名
  final String currentSeason;

  /// 今期のシーズン表示名
  final String currentSeasonText;

  /// 今期おすすめ（上位5）
  final List<Work> recommended;

  /// 今期話題（おすすめ除く）
  final List<Work> currentTrending;

  /// 前クール以前の話題作（横スクロール用）
  final List<SeasonWorks> previousSeasonTrending;
}

/// クールごとの作品一覧
final class SeasonWorks {
  /// クール作品一覧を作成
  const SeasonWorks({
    required this.season,
    required this.seasonText,
    required this.works,
  });

  /// シーズン名
  final String season;

  /// シーズン表示名
  final String seasonText;

  /// 作品一覧
  final List<Work> works;
}
