import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:anipick/core/auth/auth_session_controller.dart';
import 'package:anipick/core/error/failure.dart';
import 'package:anipick/core/error/ui_error.dart';
import 'package:anipick/features/discover/domain/entities/work.dart';
import 'package:anipick/features/discover/presentation/controllers/discover_controller.dart';
import 'package:anipick/features/discover/presentation/states/discover_ui_state.dart';
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
          final uiError = _mapErrorToUiError(e);
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

UiError _mapErrorToUiError(Object error) {
  final failure = switch (error) {
    DiscoverException(failure: final failure) => failure,
    Failure() => error,
    _ => const UnexpectedFailure(),
  };

  return switch (failure) {
    NetworkFailure() => const UiError(message: '通信に失敗しました'),
    UnauthorizedFailure() => const UiError(message: '認証に失敗しました'),
    UnexpectedFailure() => const UiError(message: '予期しないエラーが発生しました'),
  };
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
    final topWorks = state.recommended.isNotEmpty
        ? state.recommended
        : state.currentTrending;

    final navigationTopPadding = MediaQuery.paddingOf(context).top;

    return ColoredBox(
      color: const Color(0xFF252032),
      child: ListView(
        padding: EdgeInsets.only(top: navigationTopPadding, bottom: 24),
        children: [
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
    final works = widget.works;
    final heroHeight = MediaQuery.sizeOf(context).width * 9 / 16;
    const infoHeight = 220.0;

    return SizedBox(
      height: heroHeight + infoHeight,
      child: PageView.builder(
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
                                return const ColoredBox(
                                  color: Color(0xFF252032),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const ColoredBox(
                                  color: Color(0xFF252032),
                                );
                              },
                            )
                          else
                            const ColoredBox(color: Color(0xFF252032)),
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
                                    const Color(0xFF252032),
                                    const Color(
                                      0xFF010618,
                                    ).withValues(alpha: 0),
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
                                    const Color(
                                      0xFF252032,
                                    ).withValues(alpha: 0),
                                    const Color(0xFF252032),
                                  ],
                                  stops: const [0, 0.9],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          left: 16,
                          right: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _GlassIconButton(
                              icon: Icons.refresh,
                              onPressed: widget.onReload,
                            ),
                            _GlassIconButton(
                              icon: Icons.logout,
                              onPressed: widget.isAuthLoading
                                  ? null
                                  : widget.onSignOut,
                            ),
                          ],
                        ),
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
                      Text(
                        '今期の話題',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            work.title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
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
                      const SizedBox(height: 12),
                      _PageDots(count: widget.works.length, index: _index),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

final class _GlassIconButton extends StatelessWidget {
  const _GlassIconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(1000),
      child: Material(
        color: Colors.white.withValues(alpha: 0.08),
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: 44,
            height: 44,
            child: Icon(icon, color: Colors.white.withValues(alpha: 0.9)),
          ),
        ),
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(1000),
      child: Material(
        color: const Color(0xFF0091FF),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(500),
      child: Material(
        color: const Color(0xFF767680).withValues(alpha: 0.24),
        child: InkWell(
          onTap: onPressed,
          child: const SizedBox(
            width: 50,
            height: 50,
            child: Icon(Icons.more_horiz, color: Colors.white),
          ),
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
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconTheme(
            data: IconThemeData(
              color: Colors.white.withValues(alpha: 0.6),
            ),
            child: trailing,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.chevron_right,
            size: 18,
            color: Colors.white.withValues(alpha: 0.6),
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
                        return const ColoredBox(color: Color(0xFF3A3548));
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const ColoredBox(color: Color(0xFF3A3548));
                      },
                    )
                  : const ColoredBox(color: Color(0xFF3A3548)),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            work.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFFF9FAFC),
            ),
          ),
        ],
      ),
    );
  }
}
