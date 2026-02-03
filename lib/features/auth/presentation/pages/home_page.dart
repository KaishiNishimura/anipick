import 'package:anipick/core/auth/auth_session_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ホーム画面を表示
final class HomePage extends ConsumerWidget {
  /// 画面を作成
  const HomePage({super.key});

  @override
  /// 画面を構築
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(authSessionControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
        actions: [
          TextButton(
            onPressed: asyncState.isLoading
                ? null
                : () async {
                    await ref
                        .read(authSessionControllerProvider.notifier)
                        .signOut();
                  },
            child: const Text('ログアウト'),
          ),
        ],
      ),
      body: Center(
        child: asyncState.when(
          data: (state) => Text(
            state.accessToken == null ? '未ログイン' : 'ログイン済み（token保存済み）',
          ),
          error: (_, _) => const Text('エラー'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
