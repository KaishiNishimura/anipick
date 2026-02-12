import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:anipick/core/theme/app_theme.dart';
import 'package:anipick/features/auth/provider/auth_controller.dart';
import 'package:anipick/views/pages/home/home_page.dart';
import 'package:anipick/views/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// アプリを起動
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/// アプリ全体のウィジェットを構築
final class MyApp extends StatelessWidget {
  /// ウィジェットを作成
  const MyApp({super.key});

  @override
  /// ウィジェットを構築
  Widget build(BuildContext context) {
    return AdaptiveApp(
      title: 'AniPick',
      themeMode: ThemeMode.dark,
      materialLightTheme: AppTheme.dark,
      materialDarkTheme: AppTheme.dark,
      cupertinoLightTheme: AppTheme.cupertinoDark,
      cupertinoDarkTheme: AppTheme.cupertinoDark,
      home: const AppRootPage(),
    );
  }
}

/// 認証状態に応じて初期画面を切り替え
final class AppRootPage extends ConsumerWidget {
  /// ウィジェットを作成
  const AppRootPage({super.key});

  @override
  /// ウィジェットを構築
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);

    return auth.when(
      data: (state) => state.isSignedIn ? const HomePage() : const LoginPage(),
      loading: () => const AdaptiveScaffold(body: SizedBox.shrink()),
      error: (_, _) => const AdaptiveScaffold(
        body: Center(child: Text('起動に失敗しました')),
      ),
    );
  }
}
