import 'package:anipick/features/auth/presentation/controllers/auth_controller.dart';
import 'package:anipick/features/auth/presentation/pages/home_page.dart';
import 'package:anipick/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// アプリを起動
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/// アプリ全体のウィジェットを構築
class MyApp extends StatelessWidget {
  /// ウィジェットを作成
  const MyApp({super.key});

  @override
  /// ウィジェットを構築
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anipick',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AppRootPage(),
    );
  }
}

/// 認証状態に応じて初期画面を切り替え
class AppRootPage extends ConsumerWidget {
  /// ウィジェットを作成
  const AppRootPage({super.key});

  @override
  /// ウィジェットを構築
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);

    return auth.when(
      data: (state) => state.isSignedIn ? const HomePage() : const LoginPage(),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => const Scaffold(
        body: Center(child: Text('起動に失敗しました')),
      ),
    );
  }
}
