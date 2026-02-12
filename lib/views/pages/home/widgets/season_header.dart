part of '../discover_page.dart';

final class _SeasonHeader extends StatelessWidget {
  const _SeasonHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: AppTextStyles.title2Emphasized,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.chevron_right,
              size: 18,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
