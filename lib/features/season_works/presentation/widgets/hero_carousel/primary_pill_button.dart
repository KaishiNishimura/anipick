import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// カスタムピルボタン
final class PrimaryPillButton extends StatelessWidget {
  /// ウィジェットを作成
  const PrimaryPillButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  static const _pillBorderRadius = 1000.0;
  static const _horizontalPadding = 20.0;
  static const _iconSize = 18.0;
  static const _iconLabelGap = 6.0;

  /// ラベル
  final String label;

  /// アイコン
  final IconData icon;

  /// 押下コールバック
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(_pillBorderRadius),
      child: AdaptiveButton.child(
        onPressed: onPressed,
        color: colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: _iconSize),
              const Gap(_iconLabelGap),
              Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
