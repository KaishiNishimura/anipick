import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:anipick/core/exceptions/app_exception.dart';
import 'package:anipick/core/theme/app_text_styles.dart';
import 'package:anipick/features/auth/presentation/auth_controller.dart';
import 'package:anipick/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// サインイン画面を表示
final class LoginPage extends HookConsumerWidget {
  /// 画面を作成
  const LoginPage({super.key});

  static const _logoWidth = 150.0;
  static const _logoHeight = 119.0;
  static const _buttonPadding = 20.0;
  static const _spinnerSize = 18.0;
  static const _spinnerStrokeWidth = 2.0;
  static const _logoBottomGap = 20.0;
  static const _taglineBottomGap = 50.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState<bool>(false);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Future<void> onPressedLogin() async {
      isLoading.value = true;
      try {
        await ref.read(authControllerProvider.notifier).signIn();
      } on AppException catch (e) {
        if (context.mounted) {
          AdaptiveSnackBar.show(
            context,
            message: e.message,
            type: AdaptiveSnackBarType.error,
          );
        }
      } finally {
        isLoading.value = false;
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
                  width: _logoWidth,
                  height: _logoHeight,
                  fit: BoxFit.contain,
                ),
                const Gap(_logoBottomGap),
                const Text(
                  '次に観るアニメが、すぐ見つかる',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title2Emphasized,
                ),
                const Gap(_taglineBottomGap),
              ],
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: _buttonPadding,
                  left: _buttonPadding,
                  right: _buttonPadding,
                ),
                child: AdaptiveButton.child(
                  onPressed: switch (isLoading.value) {
                    true => null,
                    false => onPressedLogin,
                  },
                  size: AdaptiveButtonSize.large,
                  color: colorScheme.primary,
                  enabled: !isLoading.value,
                  child: switch (isLoading.value) {
                    true => const SizedBox(
                      width: _spinnerSize,
                      height: _spinnerSize,
                      child: CircularProgressIndicator(
                        strokeWidth: _spinnerStrokeWidth,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                    false => const Text(
                      'Annictアカウントで始める',
                      style: AppTextStyles.bodyEmphasized,
                    ),
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
