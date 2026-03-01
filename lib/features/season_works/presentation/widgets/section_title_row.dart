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

  /// タイトル
  final String title;

  /// 末尾ウィジェット
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
              color: Colors.white.withValues(alpha: 0.6),
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
