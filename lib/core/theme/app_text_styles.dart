import 'package:flutter/material.dart';

/// アプリ内で利用する [TextStyle] を集約した定義クラス
final class AppTextStyles {
  /// インスタンス化を禁止
  const AppTextStyles._();

  /// 大きなタイトルの強調スタイル
  static const largeTitleEmphasized = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    height: 41 / 34,
    letterSpacing: -0.4,
    fontFamily: 'SF Pro',
    fontFamilyFallback: <String>[
      'Hiragino Kaku Gothic ProN',
      'Hiragino Kaku Gothic Pro',
    ],
  );

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

  /// カールアウトの通常スタイル
  static const callOutRegular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 21 / 16,
    letterSpacing: -0.31,
    fontFamily: 'SF Pro',
    fontFamilyFallback: <String>[
      'Hiragino Kaku Gothic ProN',
      'Hiragino Kaku Gothic Pro',
    ],
  );

  /// キャプション1の通常スタイル
  static const caption1Regular = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    letterSpacing: 0,
    fontFamily: 'SF Pro',
    fontFamilyFallback: <String>[
      'Hiragino Kaku Gothic ProN',
      'Hiragino Kaku Gothic Pro',
    ],
  );
}
