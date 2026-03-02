import 'package:anipick/core/theme/app_text_styles.dart';
import 'package:anipick/features/season_works/presentation/widgets/hero_carousel/glass_circle_button.dart';
import 'package:anipick/features/season_works/presentation/widgets/hero_carousel/primary_pill_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// ヒーロー情報エリア（タイトル + ボタン）
final class HeroInfo extends StatelessWidget {
  /// ウィジェットを作成
  const HeroInfo({required this.title, super.key});

  /// 情報エリアの高さ
  static const infoHeight = 220.0;

  static const _topPadding = 12.0;
  static const _bottomPadding = 56.0;
  static const _titleHorizontalPadding = 24.0;
  static const _gapAfterSubtitle = 8.0;
  static const _gapAfterTitle = 16.0;
  static const _buttonGap = 12.0;

  /// タイトル
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: infoHeight,
      child: Padding(
        padding: const EdgeInsets.only(top: _topPadding),
        child: Column(
          children: [
            const Text('今期の話題', style: AppTextStyles.callOutRegular),
            const Gap(_gapAfterSubtitle),
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
            const Gap(_gapAfterTitle),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryPillButton(
                  label: '見たい',
                  icon: Icons.add,
                  onPressed: () {},
                ),
                const Gap(_buttonGap),
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
