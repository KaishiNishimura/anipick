import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:anipick/app/router.dart';
import 'package:anipick/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// アプリ全体のウィジェット
final class App extends ConsumerWidget {
  /// ウィジェットを作成
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(routerProvider);

    return AdaptiveApp.router(
      title: 'AniPick',
      themeMode: ThemeMode.dark,
      materialLightTheme: AppTheme.dark,
      materialDarkTheme: AppTheme.dark,
      cupertinoLightTheme: AppTheme.cupertinoDark,
      cupertinoDarkTheme: AppTheme.cupertinoDark,
      routerConfig: goRouter,
    );
  }
}
