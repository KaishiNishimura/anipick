import 'package:anipick/features/season_works/domain/work.dart';
import 'package:anipick/features/season_works/presentation/widgets/poster_item.dart';
import 'package:flutter/material.dart';

/// 作品リスト（横スクロール）
final class PosterRow extends StatelessWidget {
  /// ウィジェットを作成
  const PosterRow({required this.works, super.key});

  /// 表示する作品一覧
  final List<Work> works;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: works.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final work = works[index];
          return PosterItem(work: work);
        },
      ),
    );
  }
}
