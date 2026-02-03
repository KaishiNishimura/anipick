import 'package:anipick/core/theme/app_color_scheme.dart';
import 'package:anipick/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// アプリ全体で使用する [ThemeData] 定義
final class AppTheme {
  const AppTheme._();

  /// ダークテーマ
  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: AppColorScheme.dark,
      scaffoldBackgroundColor: AppColors.accent_900,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.accent_900,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary_500,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.accent_400,
          disabledForegroundColor: AppColors.accent_500,
          elevation: 0,
        ),
      ),
    );
  }

  /// iOS 向けのライトテーマ
  static const cupertinoLight = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary_500,
    scaffoldBackgroundColor: AppColors.accent_900,
    barBackgroundColor: AppColors.accent_900,
  );

  /// iOS 向けのダークテーマ
  static const cupertinoDark = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary_500,
    scaffoldBackgroundColor: AppColors.accent_900,
    barBackgroundColor: AppColors.accent_900,
  );
}
