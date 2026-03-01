import 'package:anipick/core/theme/app_colors.dart';
import 'package:anipick/core/theme/app_text_styles.dart';
import 'package:anipick/features/season_works/domain/work.dart';
import 'package:flutter/material.dart';

/// 個別作品ポスター
final class PosterItem extends StatelessWidget {
  /// ウィジェットを作成
  const PosterItem({required this.work, super.key});

  /// 表示する作品
  final Work work;

  @override
  Widget build(BuildContext context) {
    final imageUrl = work.recommendedImageUrl;
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const ColoredBox(color: AppColors.accent_700);
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const ColoredBox(color: AppColors.accent_700);
                      },
                    )
                  : const ColoredBox(color: AppColors.accent_700),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            work.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppTextStyles.caption1Regular,
          ),
        ],
      ),
    );
  }
}
