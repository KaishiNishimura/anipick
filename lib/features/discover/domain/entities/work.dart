/// 作品を表すエンティティ
final class Work {
  /// エンティティを作成
  const Work({
    required this.id,
    required this.title,
    required this.seasonName,
    required this.seasonNameText,
    required this.recommendedImageUrl,
    required this.watchersCount,
  });

  /// Annictの作品ID
  final int id;

  /// 作品タイトル
  final String title;

  /// シーズン名 (例: 2016-spring)
  final String seasonName;

  /// シーズン名（表示用） (例: 2016年春)
  final String seasonNameText;

  /// 推奨画像URL
  final String? recommendedImageUrl;

  /// 視聴者数
  final int watchersCount;
}
