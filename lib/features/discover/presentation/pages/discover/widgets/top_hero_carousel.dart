part of '../../discover_page.dart';

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
