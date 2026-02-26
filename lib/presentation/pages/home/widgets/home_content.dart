part of '../home_page.dart';

final class _HomeContent extends ConsumerWidget {
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
        _TopHeroCarousel(),
        const SizedBox(height: 16),
        const _SectionTitleRow(
          title: '今期の話題',
          trailing: Icon(Icons.chevron_right, size: 18),
        ),
        const SizedBox(height: 12),
        current.when(
          data: (state) => _PosterRow(works: state.currentTrending),
          loading: () => const SizedBox.shrink(),
          error: (_, _) => const SizedBox.shrink(),
        ),
        const SizedBox(height: 20),

        ...previousList
            .map(
              (previous) => [
                previous.when(
                  data: (state) => _SeasonHeader(title: state.seasonText),
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                ),
                const SizedBox(height: 12),
                previous.when(
                  data: (state) => _PosterRow(works: state.works),
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
