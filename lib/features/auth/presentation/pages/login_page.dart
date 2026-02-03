import 'package:anipick/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// サインイン画面を表示
class LoginPage extends ConsumerWidget {
  /// 画面を作成
  const LoginPage({super.key});

  @override
  /// 画面を構築
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ログイン')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Annict にログインします'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: asyncState.isLoading
                    ? null
                    : () async {
                        final controller = ref.read(
                          authControllerProvider.notifier,
                        );
                        final uiError = await controller.signIn();
                        if (uiError != null && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(uiError.message)),
                          );
                        }
                      },
                child: asyncState.isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Annictでログイン'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
