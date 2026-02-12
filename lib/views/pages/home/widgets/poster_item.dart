part of '../discover_page.dart';

final class _PosterItem extends StatelessWidget {
  const _PosterItem({required this.work});

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
