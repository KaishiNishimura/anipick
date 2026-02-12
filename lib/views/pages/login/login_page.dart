import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:anipick/core/theme/app_text_styles.dart';
import 'package:anipick/features/auth/provider/auth_controller.dart';
import 'package:anipick/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// サインイン画面を表示
final class LoginPage extends ConsumerWidget {
  /// 画面を作成
  const LoginPage({super.key});

  /// サインインボタン押下
  Future<void> onPressedLogin({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final notifier = ref.read(authControllerProvider.notifier);
    final uiError = await notifier.signIn();
    if (uiError != null && context.mounted) {
      AdaptiveSnackBar.show(
        context,
        message: uiError.message,
        type: AdaptiveSnackBarType.error,
      );
    }
  }

  @override
  /// 画面を構築
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AdaptiveScaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(color: theme.scaffoldBackgroundColor),
          Assets.images.loginBg.image(fit: BoxFit.cover),
          Center(
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
                  '次に観るアニメが、すぐ見つかる',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title2Emphasized,
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: AdaptiveButton.child(
                  onPressed: state.isLoading
                      ? null
                      : () => onPressedLogin(context: context, ref: ref),
                  size: AdaptiveButtonSize.large,
                  color: colorScheme.primary,
                  enabled: !state.isLoading,
                  child: state.isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
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
