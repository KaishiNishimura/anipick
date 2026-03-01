import 'package:anipick/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// セクションタイトル行
final class SectionTitleRow extends StatelessWidget {
  /// ウィジェットを作成
  const SectionTitleRow({
    required this.title,
    required this.trailing,
    super.key,
  });

  static const _horizontalPadding = 20.0;
  static const _trailingIconOpacity = 0.6;

  /// タイトル
  final String title;

  /// 末尾ウィジェット
  final Widget trailing;

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
          IconTheme(
            data: IconThemeData(
              color: Colors.white.withValues(alpha: _trailingIconOpacity),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: trailing,
            ),
          ),
        ],
      ),
    );
  }
}
