import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:anipick/features/auth/presentation/auth_controller.dart';
import 'package:anipick/features/season_works/presentation/season_works_controller.dart';
import 'package:anipick/features/season_works/presentation/widgets/home_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ホーム画面の本体
final class HomeBody extends ConsumerWidget {
  /// ウィジェットを作成
  const HomeBody({super.key});

  static const _refreshTriggerDistance = 120.0;
  static const _refreshIndicatorSize = 72.0;
  static const _contentBottomPadding = 24.0;
  static const _settingsButtonPadding = 16.0;
  static const _indicatorRadius = 12.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                refreshTriggerPullDistance: _refreshTriggerDistance,
                refreshIndicatorExtent: _refreshIndicatorSize,
                builder: _buildRefreshIndicator,
                onRefresh: () => _onRefresh(ref),
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                  top: navigationTopPadding,
                  bottom: _contentBottomPadding,
                ),
                sliver: const HomeContent(),
              ),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: _settingsButtonPadding,
                  right: _settingsButtonPadding,
                ),
                child: AdaptivePopupMenuButton.icon<String>(
                  icon: switch (PlatformInfo.isIOS26OrHigher()) {
                    true => 'gearshape',
                    false => Icons.settings,
                  },
                  items: [
                    AdaptivePopupMenuItem(
                      label: 'ログアウト',
                      icon: switch (PlatformInfo.isIOS26OrHigher()) {
                        true => 'rectangle.portrait.and.arrow.right',
                        false => Icons.logout,
                      },
                      value: 'logout',
                    ),
                  ],
                  onSelected: (index, item) => _onMenuSelected(ref, item),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> _onRefresh(WidgetRef ref) async {
    ref
      ..invalidate(seasonWorksControllerProvider(0))
      ..invalidate(seasonWorksControllerProvider(1))
      ..invalidate(seasonWorksControllerProvider(2))
      ..invalidate(seasonWorksControllerProvider(3));
  }

  static Future<void> _onMenuSelected(
    WidgetRef ref,
    AdaptivePopupMenuItem<String> item,
  ) async {
    if (item.value == 'logout') {
      await ref.read(authControllerProvider.notifier).signOut();
    }
  }

  static Widget _buildRefreshIndicator(
    BuildContext context,
    RefreshIndicatorMode refreshState,
    double pulledExtent,
    double refreshTriggerPullDistance,
    double refreshIndicatorExtent,
  ) {
    final safePulledExtent = pulledExtent.clamp(0.0, refreshIndicatorExtent);
    final opacity = (safePulledExtent / refreshIndicatorExtent).clamp(0.0, 1.0);

    final child = switch (refreshState) {
      RefreshIndicatorMode.refresh || RefreshIndicatorMode.armed =>
        const CupertinoActivityIndicator(radius: _indicatorRadius),
      RefreshIndicatorMode.drag => CupertinoActivityIndicator.partiallyRevealed(
        radius: _indicatorRadius,
        progress: (pulledExtent / refreshTriggerPullDistance).clamp(0.0, 1.0),
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
  }
}
