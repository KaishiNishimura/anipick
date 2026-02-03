import 'package:anipick/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// アプリで利用する [ColorScheme] 定義
final class AppColorScheme {
  const AppColorScheme._();

  /// ダークテーマ用の [ColorScheme]
  static const dark = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary_500,
    onPrimary: Colors.white,
    secondary: AppColors.primary_500,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: AppColors.accent_900,
    onSurface: AppColors.accent_900,
  );
}
