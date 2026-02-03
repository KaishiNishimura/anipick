import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:anipick/core/auth/auth_session_controller.dart';
import 'package:anipick/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// サインイン画面を表示
final class LoginPage extends ConsumerWidget {
  /// 画面を作成
  const LoginPage({super.key});

  @override
  /// 画面を構築
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(authSessionControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return AdaptiveScaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(color: colorScheme.surface),
          Assets.images.loginBg.image(fit: BoxFit.cover),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.images.loginLogo.image(
                    width: 150,
                    height: 119,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'あなたの“見たい”が見つかる。',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 28),
                child: SizedBox(
                  width: double.infinity,
                  child: AdaptiveButton.child(
                    onPressed: asyncState.isLoading
                        ? null
                        : () async {
                            final controller = ref.read(
                              authSessionControllerProvider.notifier,
                            );
                            final uiError = await controller.signIn();
                            if (uiError != null && context.mounted) {
                              AdaptiveSnackBar.show(
                                context,
                                message: uiError.message,
                                type: AdaptiveSnackBarType.error,
                              );
                            }
                          },
                    enabled: !asyncState.isLoading,
                    color: colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    borderRadius: BorderRadius.circular(999),
                    child: asyncState.isLoading
                        ? SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colorScheme.onPrimary,
                            ),
                          )
                        : const Text(
                            'Annictアカウントで始める',
                            style: TextStyle(
                              fontSize: 17,
                              height: 22 / 17,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
