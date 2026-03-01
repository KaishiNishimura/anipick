import 'package:anipick/features/season_works/domain/season_works.dart';
import 'package:anipick/features/season_works/presentation/season_works_controller.dart';
import 'package:anipick/features/season_works/presentation/widgets/hero_carousel/top_hero_carousel.dart';
import 'package:anipick/features/season_works/presentation/widgets/poster/poster_row.dart';
import 'package:anipick/features/season_works/presentation/widgets/season_header.dart';
import 'package:anipick/features/season_works/presentation/widgets/section_title_row.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ホーム画面のコンテンツ一覧
final class HomeContent extends ConsumerWidget {
  /// ウィジェットを作成
  const HomeContent({super.key});

  static const _chevronSize = 18.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(seasonWorksControllerProvider(0));
    final previousList = [
      ref.watch(seasonWorksControllerProvider(1)),
      ref.watch(seasonWorksControllerProvider(2)),
      ref.watch(seasonWorksControllerProvider(3)),
    ];

    return SliverList(
      delegate: SliverChildListDelegate([
        const TopHeroCarousel(),
        const Gap(16),
        const SectionTitleRow(
          title: '今期の話題',
          trailing: Icon(Icons.chevron_right, size: _chevronSize),
        ),
        const Gap(12),
        switch (current) {
          AsyncData(:final value) => PosterRow(works: value.currentTrending),
          _ => const SizedBox.shrink(),
        },
        const Gap(20),
        ...previousList.map(
          (previous) => switch (previous) {
            AsyncData(:final value) => _PreviousSeasonSection(
              seasonWorks: value,
            ),
            _ => const SizedBox.shrink(),
          },
        ),
      ]),
    );
  }
}

/// 前シーズンセクション（ヘッダー + ポスター行）
final class _PreviousSeasonSection extends StatelessWidget {
  const _PreviousSeasonSection({required this.seasonWorks});

  final SeasonWorks seasonWorks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeasonHeader(title: seasonWorks.seasonText),
        const Gap(12),
        PosterRow(works: seasonWorks.works),
        const Gap(20),
      ],
    );
  }
}
