import 'package:flutter/material.dart';

/// アプリ内で利用する [TextStyle] を集約した定義クラス
final class AppTextStyles {
  /// インスタンス化を禁止
  const AppTextStyles._();

  /// タイトル2の強調スタイル
  static const title2Emphasized = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 28 / 22,
    letterSpacing: -0.26,
    fontFamily: 'SF Pro',
    fontFamilyFallback: <String>[
      'Hiragino Kaku Gothic ProN',
      'Hiragino Kaku Gothic Pro',
    ],
  );

  /// ボディの強調スタイル
  static const bodyEmphasized = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    height: 22 / 17,
    letterSpacing: -0.43,
    fontFamily: 'SF Pro',
    fontFamilyFallback: <String>[
      'Hiragino Kaku Gothic ProN',
      'Hiragino Kaku Gothic Pro',
    ],
  );
}
