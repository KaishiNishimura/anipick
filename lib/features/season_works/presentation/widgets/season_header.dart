import 'package:anipick/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// シーズンタイトル表示
final class SeasonHeader extends StatelessWidget {
  /// ウィジェットを作成
  const SeasonHeader({required this.title, super.key});

  /// シーズン名
  final String title;

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
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.chevron_right,
              size: 18,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
