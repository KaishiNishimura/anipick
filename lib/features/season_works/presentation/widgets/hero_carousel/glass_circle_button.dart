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

  static const _buttonSize = 50.0;

  /// アイコン
  final IconData icon;

  /// 押下コールバック
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_buttonSize),
      child: AdaptiveButton.child(
        onPressed: onPressed,
        color: AppColors.accent_300,
        child: SizedBox(
          width: _buttonSize,
          height: _buttonSize,
          child: Icon(icon, color: AppColors.accent_700),
        ),
      ),
    );
  }
}
