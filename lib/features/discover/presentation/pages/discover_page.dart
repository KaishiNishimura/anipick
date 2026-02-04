import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:anipick/core/auth/auth_session_controller.dart';
import 'package:anipick/core/error/ui_error.dart';
import 'package:anipick/core/theme/app_colors.dart';
import 'package:anipick/core/theme/app_text_styles.dart';
import 'package:anipick/features/discover/domain/entities/work.dart';
import 'package:anipick/features/discover/presentation/controllers/discover_controller.dart';
import 'package:anipick/features/discover/presentation/states/discover_ui_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Discover（ホーム）画面を表示
final class DiscoverPage extends ConsumerWidget {
  /// 画面を作成
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authSessionControllerProvider);
    final asyncState = ref.watch(discoverControllerProvider);

    return AdaptiveScaffold(
      body: asyncState.when(
        skipLoadingOnReload: true,
        skipLoadingOnRefresh: true,
        data: (state) => _DiscoverBody(
          state: state,
          isAuthLoading: auth.isLoading,
          onReload: asyncState.isLoading
              ? null
              : () async {
                  await ref.read(discoverControllerProvider.notifier).reload();
                },
          onSignOut: auth.isLoading
              ? null
              : () async {
                  await ref
                      .read(authSessionControllerProvider.notifier)
                      .signOut();
                },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) {
          final uiError = e is UiError
              ? e
              : const UiError(message: '予期しないエラーが発生しました');
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(uiError.message),
                  const SizedBox(height: 12),
                  AdaptiveButton.child(
                    onPressed: () async {
                      await ref
                          .read(discoverControllerProvider.notifier)
                          .reload();
                    },
                    child: const Text('再試行'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

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

    final isCupertinoRefresh = switch (defaultTargetPlatform) {
      TargetPlatform.iOS || TargetPlatform.macOS => true,
      _ => false,
    };

    return ColoredBox(
      color: scaffoldBackgroundColor,
      child: Stack(
        children: [
          if (isCupertinoRefresh)
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
            )
          else
            RefreshIndicator(
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
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                  top: navigationTopPadding,
                  bottom: 24,
                ),
                children: contentChildren,
              ),
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

final class _TopHeroCarousel extends StatefulWidget {
  const _TopHeroCarousel({
    required this.works,
    required this.onReload,
    required this.onSignOut,
    required this.isAuthLoading,
  });

  final List<Work> works;
  final Future<void> Function()? onReload;
  final Future<void> Function()? onSignOut;
  final bool isAuthLoading;

  @override
  State<_TopHeroCarousel> createState() => _TopHeroCarouselState();
}

final class _TopHeroCarouselState extends State<_TopHeroCarousel> {
  late final PageController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaffoldBackgroundColor = theme.scaffoldBackgroundColor;
    final works = widget.works;
    final heroHeight = MediaQuery.sizeOf(context).width * 9 / 16;
    const infoHeight = 220.0;

    return SizedBox(
      height: heroHeight + infoHeight,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: works.isEmpty ? 1 : works.length,
            onPageChanged: (value) => setState(() => _index = value),
            itemBuilder: (context, index) {
              final work = works.isEmpty
                  ? const Work(
                      id: 0,
                      title: '',
                      seasonName: '',
                      seasonNameText: '',
                      recommendedImageUrl: null,
                      watchersCount: 0,
                    )
                  : works[index];

              final imageUrl = work.recommendedImageUrl;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: heroHeight,
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              if (imageUrl != null && imageUrl.isNotEmpty)
                                Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return ColoredBox(
                                      color: scaffoldBackgroundColor,
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return ColoredBox(
                                      color: scaffoldBackgroundColor,
                                    );
                                  },
                                )
                              else
                                ColoredBox(color: scaffoldBackgroundColor),
                              Positioned(
                                left: 0,
                                top: 0,
                                right: 0,
                                height: 80,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        scaffoldBackgroundColor,
                                        scaffoldBackgroundColor.withValues(
                                          alpha: 0,
                                        ),
                                      ],
                                      stops: const [0.1, 1],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                height: 140,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        scaffoldBackgroundColor.withValues(
                                          alpha: 0,
                                        ),
                                        scaffoldBackgroundColor,
                                      ],
                                      stops: const [0, 0.9],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: infoHeight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        children: [
                          const Text(
                            '今期の話題',
                            style: AppTextStyles.callOutRegular,
                          ),
                          const SizedBox(height: 8),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  work.title,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.clip,
                                  style: AppTextStyles.largeTitleEmphasized,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _PrimaryPillButton(
                                label: '見たい',
                                icon: Icons.add,
                                onPressed: () {},
                              ),
                              const SizedBox(width: 12),
                              _GlassCircleButton(
                                icon: Icons.more_horiz,
                                onPressed: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 12 + 44),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 12,
            child: SizedBox(
              width: double.infinity,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragStart: (_) {},
                onHorizontalDragUpdate: (_) {},
                onHorizontalDragEnd: (_) {},
                child: _PageDots(count: widget.works.length, index: _index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class _PrimaryPillButton extends StatelessWidget {
  const _PrimaryPillButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(1000),
      child: AdaptiveButton.child(
        onPressed: onPressed,
        color: colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 6),
              Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _GlassCircleButton extends StatelessWidget {
  const _GlassCircleButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(500),
      child: AdaptiveButton.child(
        onPressed: onPressed,
        color: colorScheme.onSurface.withValues(alpha: 0.24),
        child: SizedBox(
          width: 50,
          height: 50,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}

final class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    final dotCount = count.clamp(1, 3);
    return SizedBox(
      height: 44,
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(dotCount, (i) {
                final active = i == index;
                return Padding(
                  padding: EdgeInsets.only(right: i == dotCount - 1 ? 0 : 8),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: active ? 1 : 0.3),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const SizedBox(width: 8, height: 8),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

final class _SectionTitleRow extends StatelessWidget {
  const _SectionTitleRow({required this.title, required this.trailing});

  final String title;
  final Widget trailing;

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
          IconTheme(
            data: IconThemeData(
              color: Colors.white.withValues(alpha: 0.6),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: trailing,
            ),
          ),
        ],
      ),
    );
  }
}

final class _SeasonHeader extends StatelessWidget {
  const _SeasonHeader({required this.title});

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

final class _PosterRow extends StatelessWidget {
  const _PosterRow({required this.works});

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
          return _PosterItem(work: work);
        },
      ),
    );
  }
}

final class _PosterItem extends StatelessWidget {
  const _PosterItem({required this.work});

  final Work work;

  @override
  Widget build(BuildContext context) {
    final imageUrl = work.recommendedImageUrl;
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const ColoredBox(color: AppColors.accent_700);
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const ColoredBox(color: AppColors.accent_700);
                      },
                    )
                  : const ColoredBox(color: AppColors.accent_700),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            work.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppTextStyles.caption1Regular,
          ),
        ],
      ),
    );
  }
}
