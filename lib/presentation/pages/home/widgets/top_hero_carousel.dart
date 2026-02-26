part of '../home_page.dart';

final class _TopHeroCarousel extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = usePageController();
    final index = useState<int>(0);
    final theme = Theme.of(context);
    final scaffoldBackgroundColor = theme.scaffoldBackgroundColor;
    final heroHeight = MediaQuery.sizeOf(context).width * 9 / 16;
    const infoHeight = 220.0;

    final home = ref.watch(seasonWorksControllerProvider(0));

    return home.when(
      data: (state) => SizedBox(
        height: heroHeight + infoHeight,
        child: Stack(
          children: [
            PageView.builder(
              controller: controller,
              itemCount: state.recommended.isEmpty
                  ? 1
                  : state.recommended.length,
              onPageChanged: (value) => index.value = value,
              itemBuilder: (context, index) {
                final work = state.recommended.isEmpty
                    ? const Work(
                        id: 0,
                        title: '',
                        seasonName: '',
                        seasonNameText: '',
                        recommendedImageUrl: null,
                        watchersCount: 0,
                      )
                    : state.recommended[index];

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
                  child: _PageDots(
                    count: state.recommended.length,
                    index: index.value,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
