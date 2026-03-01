import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:anipick/features/auth/presentation/auth_controller.dart';
import 'package:anipick/features/season_works/presentation/season_works_controller.dart';
import 'package:anipick/features/season_works/presentation/widgets/home_body.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ホーム画面を表示
final class HomePage extends ConsumerWidget {
  /// 画面を作成
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdaptiveScaffold(
      body: HomeBody(
        onSignOut: () async {
          await ref.read(authControllerProvider.notifier).signOut();
        },
        onRefresh: () async {
          ref
            ..invalidate(seasonWorksControllerProvider(0))
            ..invalidate(seasonWorksControllerProvider(1))
            ..invalidate(seasonWorksControllerProvider(2))
            ..invalidate(seasonWorksControllerProvider(3));
        },
      ),
    );
  }
}
