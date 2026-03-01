import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:anipick/features/season_works/presentation/widgets/home_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// ホーム画面の本体
final class HomeBody extends StatelessWidget {
  /// ウィジェットを作成
  const HomeBody({
    required this.onSignOut,
    required this.onRefresh,
    super.key,
  });

  /// サインアウトコールバック
  final Future<void> Function() onSignOut;

  /// リフレッシュコールバック
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaffoldBackgroundColor = theme.scaffoldBackgroundColor;
    final navigationTopPadding = MediaQuery.paddingOf(context).top;

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
                          const CupertinoActivityIndicator(radius: 12),
                        RefreshIndicatorMode.drag =>
                          CupertinoActivityIndicator.partiallyRevealed(
                            radius: 12,
                            progress:
                                (pulledExtent / refreshTriggerPullDistance)
                                    .clamp(
                                      0.0,
                                      1.0,
                                    ),
                          ),
                        _ => const SizedBox.shrink(),
                      };

                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: safePulledExtent,
                          child: Center(
                            child: Opacity(opacity: opacity, child: child),
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
                sliver: const HomeContent(),
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
                      await onSignOut();
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
