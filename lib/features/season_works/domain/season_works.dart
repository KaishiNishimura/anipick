import 'package:anipick/features/season_works/domain/work.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'season_works.freezed.dart';

/// クールごとの作品一覧
@freezed
abstract class SeasonWorks with _$SeasonWorks {
  /// 作品一覧を作成
  const factory SeasonWorks({
    required String season,
    required String seasonText,
    required List<Work> works,
  }) = _SeasonWorks;

  const SeasonWorks._();

  /// 今期おすすめ（上位5）
  List<Work> get recommended => works.take(5).toList();

  /// 今期話題（おすすめ除く）
  List<Work> get currentTrending => works.skip(5).toList();
}
