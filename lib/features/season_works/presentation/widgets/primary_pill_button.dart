import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';

/// カスタムピルボタン
final class PrimaryPillButton extends StatelessWidget {
  /// ウィジェットを作成
  const PrimaryPillButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    super.key,
  });

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
      borderRadius: BorderRadius.circular(1000),
      child: AdaptiveButton.child(
        onPressed: onPressed,
        color: colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 6),
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
