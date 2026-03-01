import 'package:flutter/material.dart';

/// ページインジケーター
final class PageDots extends StatelessWidget {
  /// ウィジェットを作成
  const PageDots({required this.count, required this.index, super.key});

  /// ドット数
  final int count;

  /// 現在のインデックス
  final int index;

  @override
  Widget build(BuildContext context) {
    final dotCount = count <= 0 ? 1 : count;
    final safeIndex = index.clamp(0, dotCount - 1);
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
                final active = i == safeIndex;
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
