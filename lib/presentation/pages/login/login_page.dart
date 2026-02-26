import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:anipick/application/usecases/auth/sign_in.dart';
import 'package:anipick/core/theme/app_text_styles.dart';
import 'package:anipick/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// サインイン画面を表示
final class LoginPage extends HookConsumerWidget {
  /// 画面を作成
  const LoginPage({super.key});

  @override
  /// 画面を構築
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState<bool>(false);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    /// サインインボタン押下
    Future<void> onPressedLogin() async {
      isLoading.value = true;

      /// サインインを実行
      final usecase = ref.read(signInUseCaseProvider);
      final uiError = await usecase();
      isLoading.value = false;
      if (uiError != null && context.mounted) {
        AdaptiveSnackBar.show(
          context,
          message: uiError.message,
          type: AdaptiveSnackBarType.error,
        );
      }
    }

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
                  onPressed: isLoading.value ? null : onPressedLogin,
                  size: AdaptiveButtonSize.large,
                  color: colorScheme.primary,
                  enabled: !isLoading.value,
                  child: isLoading.value
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
