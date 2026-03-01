import 'package:anipick/features/season_works/presentation/season_works_controller.dart';
import 'package:anipick/features/season_works/presentation/widgets/poster_row.dart';
import 'package:anipick/features/season_works/presentation/widgets/season_header.dart';
import 'package:anipick/features/season_works/presentation/widgets/section_title_row.dart';
import 'package:anipick/features/season_works/presentation/widgets/top_hero_carousel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ホーム画面のコンテンツ一覧
final class HomeContent extends ConsumerWidget {
  /// ウィジェットを作成
  const HomeContent({super.key});

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
        const SizedBox(height: 16),
        const SectionTitleRow(
          title: '今期の話題',
          trailing: Icon(Icons.chevron_right, size: 18),
        ),
        const SizedBox(height: 12),
        current.when(
          data: (state) => PosterRow(works: state.currentTrending),
          loading: () => const SizedBox.shrink(),
          error: (_, _) => const SizedBox.shrink(),
        ),
        const SizedBox(height: 20),
        ...previousList
            .map(
              (previous) => [
                previous.when(
                  data: (state) => SeasonHeader(title: state.seasonText),
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                ),
                const SizedBox(height: 12),
                previous.when(
                  data: (state) => PosterRow(works: state.works),
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                ),
                const SizedBox(height: 20),
              ],
            )
            .expand((element) => element),
      ]),
    );
  }
}
