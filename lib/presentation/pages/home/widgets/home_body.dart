part of '../home_page.dart';

final class _HomeBody extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scaffoldBackgroundColor = theme.scaffoldBackgroundColor;
    final navigationTopPadding = MediaQuery.paddingOf(context).top;

    Future<void> onPressedSignOut() {
      final usecase = ref.read(signOutUseCaseProvider);
      return usecase();
    }

    Future<void> onRefresh() async {
      final usecase = ref.read(refreshSeasonWorksUseCaseProvider);
      return usecase();
    }

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
                onRefresh: onRefresh,
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                  top: navigationTopPadding,
                  bottom: 24,
                ),
                sliver: _HomeContent(),
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
                    if (item.value == 'logout') {
                      await onPressedSignOut();
                    }
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
