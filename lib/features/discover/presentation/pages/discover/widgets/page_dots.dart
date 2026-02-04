part of '../../discover_page.dart';

final class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    final dotCount = count.clamp(1, 3);
    return SizedBox(
      height: 44,
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(dotCount, (i) {
                final active = i == index;
                return Padding(
                  padding: EdgeInsets.only(right: i == dotCount - 1 ? 0 : 8),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: active ? 1 : 0.3),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const SizedBox(width: 8, height: 8),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
