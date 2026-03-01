import 'package:freezed_annotation/freezed_annotation.dart';

part 'work.freezed.dart';

/// 作品を表すエンティティ
@freezed
abstract class Work with _$Work {
  /// エンティティを作成
  const factory Work({
    required int id,
    required String title,
    required String seasonName,
    required String seasonNameText,
    required String? recommendedImageUrl,
    required int watchersCount,
  }) = _Work;
}
