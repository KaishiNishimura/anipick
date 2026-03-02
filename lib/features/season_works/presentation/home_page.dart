import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:anipick/features/season_works/presentation/widgets/home_body.dart';
import 'package:flutter/material.dart';

/// ホーム画面を表示
final class HomePage extends StatelessWidget {
  /// 画面を作成
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdaptiveScaffold(body: HomeBody());
  }
}
