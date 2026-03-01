import 'package:flutter/material.dart';

/// ページインジケーター
final class PageDots extends StatelessWidget {
  /// ウィジェットを作成
  const PageDots({required this.count, required this.index, super.key});

  static const _touchTargetHeight = 44.0;
  static const _pillBorderRadius = 50.0;
  static const _horizontalPadding = 12.0;
  static const _verticalPadding = 8.0;
  static const _dotSize = 8.0;
  static const _dotSpacing = 8.0;

  /// ドット数
  final int count;

  /// 現在のインデックス
  final int index;

  @override
  Widget build(BuildContext context) {
    final dotCount = count <= 0 ? 1 : count;
    final safeIndex = index.clamp(0, dotCount - 1);
    return SizedBox(
      height: _touchTargetHeight,
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_pillBorderRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _horizontalPadding,
              vertical: _verticalPadding,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(dotCount, (i) {
                final active = i == safeIndex;
                return Padding(
                  padding: EdgeInsets.only(
                    right: i == dotCount - 1 ? 0 : _dotSpacing,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(
                        alpha: active ? 1 : 0.3,
                      ),
                      borderRadius: BorderRadius.circular(_pillBorderRadius),
                    ),
                    child: const SizedBox(
                      width: _dotSize,
                      height: _dotSize,
                    ),
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
