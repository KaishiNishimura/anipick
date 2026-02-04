import 'package:anipick/features/discover/domain/entities/work.dart';

/// 作品DTO
final class WorkDto {
  /// DTOを作成
  const WorkDto({
    required this.id,
    required this.title,
    required this.seasonName,
    required this.seasonNameText,
    required this.recommendedUrl,
    required this.watchersCount,
  });

  /// JSONからDTOを作成
  factory WorkDto.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as Map<String, dynamic>?;

    final rawRecommendedUrl = images?['recommended_url'] as String?;

    final facebook = images?['facebook'] as Map<String, dynamic>?;
    final rawFacebookOgImageUrl = facebook?['og_image_url'] as String?;

    final twitter = images?['twitter'] as Map<String, dynamic>?;
    final rawTwitterImageUrl = twitter?['image_url'] as String?;

    final recommendedUrl =
        _normalizeImageUrl(rawRecommendedUrl) ??
        _normalizeImageUrl(rawFacebookOgImageUrl) ??
        _normalizeImageUrl(rawTwitterImageUrl);

    return WorkDto(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      seasonName: json['season_name'] as String? ?? '',
      seasonNameText: json['season_name_text'] as String? ?? '',
      recommendedUrl: recommendedUrl,
      watchersCount: (json['watchers_count'] as num?)?.toInt() ?? 0,
    );
  }

  /// Annictの作品ID
  final int id;

  /// 作品タイトル
  final String title;

  /// シーズン名
  final String seasonName;

  /// シーズン名（表示用）
  final String seasonNameText;

  /// 推奨画像URL
  final String? recommendedUrl;

  /// 視聴者数
  final int watchersCount;

  /// エンティティへ変換
  Work toEntity() {
    return Work(
      id: id,
      title: title,
      seasonName: seasonName,
      seasonNameText: seasonNameText,
      recommendedImageUrl: recommendedUrl,
      watchersCount: watchersCount,
    );
  }

  static String? _normalizeImageUrl(String? url) {
    if (url == null || url.isEmpty) return null;

    if (url.startsWith('//')) {
      return 'https:$url';
    }

    return url;
  }
}
