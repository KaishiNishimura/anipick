import 'package:anipick/features/season_works/domain/work.dart';
import 'package:anipick/features/season_works/presentation/season_works_controller.dart';
import 'package:anipick/features/season_works/presentation/widgets/hero_carousel/hero_image.dart';
import 'package:anipick/features/season_works/presentation/widgets/hero_carousel/hero_info.dart';
import 'package:anipick/features/season_works/presentation/widgets/hero_carousel/page_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 空データ時のフォールバック
const _emptyWork = Work(
  id: 0,
  title: '',
  seasonName: '',
  seasonNameText: '',
  watchersCount: 0,
);

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
        height: heroHeight + HeroInfo.infoHeight,
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
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HeroImage(
                      imageUrl: work.recommendedImageUrl,
                      heroHeight: heroHeight,
                    ),
                    HeroInfo(title: work.title),
                  ],
                );
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
