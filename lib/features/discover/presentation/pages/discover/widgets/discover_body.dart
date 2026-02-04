part of '../../discover_page.dart';

final class _DiscoverBody extends StatelessWidget {
  const _DiscoverBody({
    required this.state,
    required this.onReload,
    required this.onSignOut,
    required this.isAuthLoading,
  });

  final DiscoverUiState state;
  final Future<void> Function()? onReload;
  final Future<void> Function()? onSignOut;
  final bool isAuthLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaffoldBackgroundColor = theme.scaffoldBackgroundColor;
    final topWorks = state.recommended.isNotEmpty
        ? state.recommended
        : state.currentTrending;

    final navigationTopPadding = MediaQuery.paddingOf(context).top;

    final contentChildren = <Widget>[
      _TopHeroCarousel(
        works: topWorks.take(3).toList(),
        onReload: onReload,
        onSignOut: onSignOut,
        isAuthLoading: isAuthLoading,
      ),
      const SizedBox(height: 16),
      const _SectionTitleRow(
        title: '今期の話題',
        trailing: Icon(Icons.chevron_right, size: 18),
      ),
      const SizedBox(height: 12),
      _PosterRow(works: state.currentTrending.take(20).toList()),
      const SizedBox(height: 20),
      for (final seasonWorks in state.previousSeasonTrending) ...[
        _SeasonHeader(title: seasonWorks.seasonText),
        const SizedBox(height: 12),
        _PosterRow(works: seasonWorks.works.take(20).toList()),
        const SizedBox(height: 20),
      ],
    ];

    return ColoredBox(
      color: scaffoldBackgroundColor,
      child: Stack(
        children: [
          CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              CupertinoSliverRefreshControl(
                refreshTriggerPullDistance: 120,
                refreshIndicatorExtent: 72,
                builder:
                    (
                      context,
                      refreshState,
                      pulledExtent,
                      refreshTriggerPullDistance,
                      refreshIndicatorExtent,
                    ) {
                      final safePulledExtent = pulledExtent.clamp(
                        0.0,
                        refreshIndicatorExtent,
                      );

                      final opacity =
                          (safePulledExtent / refreshIndicatorExtent).clamp(
                            0.0,
                            1.0,
                          );

                      final child = switch (refreshState) {
                        RefreshIndicatorMode.refresh ||
                        RefreshIndicatorMode.armed =>
                          const CupertinoActivityIndicator(
                            radius: 12,
                          ),
                        RefreshIndicatorMode.drag =>
                          CupertinoActivityIndicator.partiallyRevealed(
                            radius: 12,
                            progress:
                                (pulledExtent / refreshTriggerPullDistance)
                                    .clamp(0.0, 1.0),
                          ),
                        _ => const SizedBox.shrink(),
                      };

                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: safePulledExtent,
                          child: Center(
                            child: Opacity(
                              opacity: opacity,
                              child: child,
                            ),
                          ),
                        ),
                      );
                    },
                onRefresh: () async {
                  final reload = onReload;
                  if (reload == null) return;
                  await Future.wait([
                    reload(),
                    Future<void>.delayed(
                      const Duration(milliseconds: 800),
                    ),
                  ]);
                },
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                  top: navigationTopPadding,
                  bottom: 24,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(contentChildren),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 16, right: 16),
                child: AdaptivePopupMenuButton.icon<String>(
                  icon: PlatformInfo.isIOS26OrHigher()
                      ? 'gearshape'
                      : Icons.settings,
                  items: [
                    AdaptivePopupMenuItem(
                      label: 'ログアウト',
                      icon: PlatformInfo.isIOS26OrHigher()
                          ? 'rectangle.portrait.and.arrow.right'
                          : Icons.logout,
                      value: 'logout',
                    ),
                  ],
                  onSelected: (index, item) async {
                    if (isAuthLoading) return;
                    if (item.value != 'logout') return;
                    final signOut = onSignOut;
                    if (signOut == null) return;
                    await signOut();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
