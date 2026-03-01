import 'package:anipick/core/utils/uri_utils.dart';
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
    required int watchersCount,
    Uri? imageUrl,
    Uri? facebookOgImageUrl,
    Uri? twitterImageUrl,
  }) = _Work;

  const Work._();

  /// APIレスポンスJSONからWorkを生成
  factory Work.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as Map<String, dynamic>?;

    return Work(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      seasonName: json['season_name'] as String? ?? '',
      seasonNameText: json['season_name_text'] as String? ?? '',
      watchersCount: (json['watchers_count'] as num?)?.toInt() ?? 0,
      imageUrl: tryParseUri(images?['recommended_url'] as String?),
      facebookOgImageUrl: tryParseUri(
        (images?['facebook'] as Map<String, dynamic>?)?['og_image_url']
            as String?,
      ),
      twitterImageUrl: tryParseUri(
        (images?['twitter'] as Map<String, dynamic>?)?['image_url'] as String?,
      ),
    );
  }

  /// 推奨画像URL（imageUrl → facebookOgImageUrl → twitterImageUrl）
  Uri? get recommendedImageUrl =>
      imageUrl ?? facebookOgImageUrl ?? twitterImageUrl;
}
