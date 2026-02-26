import 'package:anipick/domain/entities/work.dart';

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

  /// 今期おすすめ（上位5）
  List<Work> get recommended => works.take(5).toList();

  /// 今期話題（おすすめ除く）
  List<Work> get currentTrending => works.skip(5).toList();
}
