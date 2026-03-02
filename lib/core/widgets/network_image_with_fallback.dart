import 'package:flutter/material.dart';

/// ネットワーク画像（ロード中・エラー時はフォールバック色を表示）
final class NetworkImageWithFallback extends StatelessWidget {
  /// ウィジェットを作成
  const NetworkImageWithFallback({
    required this.url,
    required this.fallbackColor,
    this.fit = BoxFit.cover,
    super.key,
  });

  /// 画像の URL
  final String url;

  /// ロード中・エラー時の背景色
  final Color fallbackColor;

  /// 画像のフィット方法
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return ColoredBox(color: fallbackColor);
      },
      errorBuilder: (context, error, stackTrace) {
        return ColoredBox(color: fallbackColor);
      },
    );
  }
}
