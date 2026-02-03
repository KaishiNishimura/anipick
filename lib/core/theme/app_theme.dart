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

      fontFamily: 'SF Pro Display',
      fontFamilyFallback: const [
        'Hiragino Kaku Gothic ProN',
        'Hiragino Kaku Gothic Pro',
      ],

      // 主要色（Material2 系APIや一部ウィジェットが参照するため、ColorSchemeに加えて明示）
      primaryColor: AppColors.primary_500,

      // ダイアログの背景色（`dialogBackgroundColor` は非推奨のため `DialogTheme` で指定）
      dialogTheme: const DialogThemeData(backgroundColor: AppColors.accent_900),

      // アイコンのデフォルト色
      iconTheme: const IconThemeData(color: Colors.white),
      primaryIconTheme: const IconThemeData(color: Colors.white),
      scaffoldBackgroundColor: AppColors.accent_900,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.accent_900,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // 読み込みインジケータ等の基準色
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary_500,
      ),

      // TextField など入力系の見た目をある程度統一
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: AppColors.accent_800,
        hintStyle: const TextStyle(color: AppColors.accent_400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accent_700),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accent_700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary_500),
        ),
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
  static CupertinoThemeData get cupertinoDark {
    return const CupertinoThemeData(
      brightness: Brightness.dark,

      // iOS側での強調色（CupertinoButton / スイッチ等で使われる）
      primaryColor: AppColors.primary_500,

      // iOS側のScaffold背景
      scaffoldBackgroundColor: AppColors.accent_900,

      // ナビゲーションバー等のバー背景
      barBackgroundColor: AppColors.accent_900,
    );
  }
}
