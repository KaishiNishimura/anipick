import 'package:anipick/features/season_works/domain/work.dart';
import 'package:anipick/features/season_works/presentation/widgets/poster/poster_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// 作品リスト（横スクロール）
final class PosterRow extends StatelessWidget {
  /// ウィジェットを作成
  const PosterRow({required this.works, super.key});

  static const _height = 140.0;
  static const _horizontalPadding = 20.0;
  static const _itemSpacing = 12.0;

  /// 表示する作品一覧
  final List<Work> works;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        scrollDirection: Axis.horizontal,
        itemCount: works.length,
        separatorBuilder: (context, index) => const Gap(_itemSpacing),
        itemBuilder: (context, index) => PosterItem(work: works[index]),
      ),
    );
  }
}
