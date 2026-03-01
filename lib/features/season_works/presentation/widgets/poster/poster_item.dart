import 'package:anipick/core/theme/app_colors.dart';
import 'package:anipick/core/theme/app_text_styles.dart';
import 'package:anipick/core/widgets/network_image_with_fallback.dart';
import 'package:anipick/features/season_works/domain/work.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// 個別作品ポスター
final class PosterItem extends StatelessWidget {
  /// ウィジェットを作成
  const PosterItem({required this.work, super.key});

  static const _width = 180.0;
  static const _borderRadius = 10.0;

  /// 表示する作品
  final Work work;

  @override
  Widget build(BuildContext context) {
    final imageUrl = work.recommendedImageUrl;

    return SizedBox(
      width: _width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_borderRadius),
              child: switch (imageUrl) {
                final url? => NetworkImageWithFallback(
                  url: url.toString(),
                  fallbackColor: AppColors.accent_700,
                ),
                null => const ColoredBox(color: AppColors.accent_700),
              },
            ),
          ),
          const Gap(4),
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
