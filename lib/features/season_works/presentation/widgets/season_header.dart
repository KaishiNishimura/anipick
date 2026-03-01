import 'package:anipick/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// シーズンタイトル表示
final class SeasonHeader extends StatelessWidget {
  /// ウィジェットを作成
  const SeasonHeader({required this.title, super.key});

  static const _horizontalPadding = 20.0;
  static const _chevronSize = 18.0;
  static const _chevronOpacity = 0.6;

  /// シーズン名
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: AppTextStyles.title2Emphasized,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.chevron_right,
              size: _chevronSize,
              color: Colors.white.withValues(alpha: _chevronOpacity),
            ),
          ),
        ],
      ),
    );
  }
}
