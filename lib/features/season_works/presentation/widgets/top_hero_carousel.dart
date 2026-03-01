import 'package:anipick/core/theme/app_text_styles.dart';
import 'package:anipick/core/widgets/network_image_with_fallback.dart';
import 'package:anipick/features/season_works/domain/work.dart';
import 'package:anipick/features/season_works/presentation/season_works_controller.dart';
import 'package:anipick/features/season_works/presentation/widgets/glass_circle_button.dart';
import 'package:anipick/features/season_works/presentation/widgets/page_dots.dart';
import 'package:anipick/features/season_works/presentation/widgets/primary_pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 空データ時のフォールバック
const _emptyWork = Work(
  id: 0,
  title: '',
  seasonName: '',
  seasonNameText: '',
  watchersCount: 0,
);

/// 情報エリアの高さ
const _infoHeight = 220.0;

/// トップのヒーローカルーセル
final class TopHeroCarousel extends HookConsumerWidget {
  /// ウィジェットを作成
  const TopHeroCarousel({super.key});

  static const _dotsBottomOffset = 12.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = usePageController();
    final index = useState<int>(0);
    final heroHeight = MediaQuery.sizeOf(context).width * 9 / 16;

    final home = ref.watch(seasonWorksControllerProvider(0));

    return switch (home) {
      AsyncData(:final value) => SizedBox(
        height: heroHeight + _infoHeight,
        child: Stack(
          children: [
            PageView.builder(
              controller: controller,
              itemCount: value.recommended.isEmpty
                  ? 1
                  : value.recommended.length,
              onPageChanged: (value) => index.value = value,
              itemBuilder: (context, pageIndex) {
                final work = value.recommended.isEmpty
                    ? _emptyWork
                    : value.recommended[pageIndex];
                return _HeroPage(work: work, heroHeight: heroHeight);
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: _dotsBottomOffset,
              child: SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onHorizontalDragStart: (_) {},
                  onHorizontalDragUpdate: (_) {},
                  onHorizontalDragEnd: (_) {},
                  child: PageDots(
                    count: value.recommended.length,
                    index: index.value,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}

/// ヒーローページ（画像 + 情報エリア）
final class _HeroPage extends StatelessWidget {
  const _HeroPage({required this.work, required this.heroHeight});

  final Work work;
  final double heroHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _HeroImage(
          imageUrl: work.recommendedImageUrl,
          heroHeight: heroHeight,
        ),
        _HeroInfo(title: work.title),
      ],
    );
  }
}

/// ヒーロー画像 + 上下グラデーション
final class _HeroImage extends StatelessWidget {
  const _HeroImage({required this.imageUrl, required this.heroHeight});

  static const _topGradientHeight = 80.0;
  static const _bottomGradientHeight = 140.0;

  final Uri? imageUrl;
  final double heroHeight;

  @override
  Widget build(BuildContext context) {
    final scaffoldBgColor = Theme.of(context).scaffoldBackgroundColor;

    return SizedBox(
      height: heroHeight,
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              fit: StackFit.expand,
              children: [
                switch (imageUrl) {
                  final url? => NetworkImageWithFallback(
                    url: url.toString(),
                    fallbackColor: scaffoldBgColor,
                  ),
                  null => ColoredBox(color: scaffoldBgColor),
                },
                _GradientOverlay(
                  color: scaffoldBgColor,
                  alignment: Alignment.topCenter,
                  height: _topGradientHeight,
                  stops: const [0.1, 1],
                ),
                _GradientOverlay(
                  color: scaffoldBgColor,
                  alignment: Alignment.bottomCenter,
                  height: _bottomGradientHeight,
                  stops: const [0, 0.9],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 上下グラデーションオーバーレイ
final class _GradientOverlay extends StatelessWidget {
  const _GradientOverlay({
    required this.color,
    required this.alignment,
    required this.height,
    required this.stops,
  });

  final Color color;
  final Alignment alignment;
  final double height;
  final List<double> stops;

  @override
  Widget build(BuildContext context) {
    final isTop = alignment == Alignment.topCenter;

    return Positioned(
      left: 0,
      right: 0,
      top: isTop ? 0 : null,
      bottom: isTop ? null : 0,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isTop
                ? [color, color.withValues(alpha: 0)]
                : [color.withValues(alpha: 0), color],
            stops: stops,
          ),
        ),
      ),
    );
  }
}

/// ヒーロー情報エリア（タイトル + ボタン）
final class _HeroInfo extends StatelessWidget {
  const _HeroInfo({required this.title});

  static const _topPadding = 12.0;
  static const _bottomPadding = 56.0;
  static const _titleHorizontalPadding = 24.0;

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _infoHeight,
      child: Padding(
        padding: const EdgeInsets.only(top: _topPadding),
        child: Column(
          children: [
            const Text('今期の話題', style: AppTextStyles.callOutRegular),
            const Gap(8),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: _titleHorizontalPadding,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.clip,
                    style: AppTextStyles.largeTitleEmphasized,
                  ),
                ),
              ),
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryPillButton(
                  label: '見たい',
                  icon: Icons.add,
                  onPressed: () {},
                ),
                const Gap(12),
                GlassCircleButton(
                  icon: Icons.more_horiz,
                  onPressed: () {},
                ),
              ],
            ),
            const Gap(_bottomPadding),
          ],
        ),
      ),
    );
  }
}
