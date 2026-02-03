import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:anipick/core/auth/auth_session_controller.dart';
import 'package:anipick/core/theme/app_text_styles.dart';
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AdaptiveScaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(color: theme.scaffoldBackgroundColor),
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
                  const Text(
                    'あなたの“見たい”が見つかる。',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title2Emphasized,
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
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
                  size: AdaptiveButtonSize.large,
                  color: colorScheme.primary,
                  enabled: !asyncState.isLoading,
                  borderRadius: BorderRadius.circular(999),
                  child: const Text(
                    'Annictアカウントで始める',
                    style: AppTextStyles.bodyEmphasized,
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
