import 'package:anipick/core/widgets/network_image_with_fallback.dart';
import 'package:flutter/material.dart';

/// ヒーロー画像 + 上下グラデーション
final class HeroImage extends StatelessWidget {
  /// ウィジェットを作成
  const HeroImage({
    required this.imageUrl,
    required this.heroHeight,
    super.key,
  });

  static const _topGradientHeight = 80.0;
  static const _bottomGradientHeight = 140.0;

  /// 画像 URL
  final Uri? imageUrl;

  /// ヒーロー画像の高さ
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
