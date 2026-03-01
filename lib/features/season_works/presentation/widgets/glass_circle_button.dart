import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:anipick/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// 円形ガラスボタン
final class GlassCircleButton extends StatelessWidget {
  /// ウィジェットを作成
  const GlassCircleButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  /// アイコン
  final IconData icon;

  /// 押下コールバック
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(500),
      child: AdaptiveButton.child(
        onPressed: onPressed,
        color: AppColors.accent_300,
        child: SizedBox(
          width: 50,
          height: 50,
          child: Icon(icon, color: AppColors.accent_700),
        ),
      ),
    );
  }
}
