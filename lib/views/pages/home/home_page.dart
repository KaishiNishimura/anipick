import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:anipick/core/error/ui_error.dart';
import 'package:anipick/core/theme/app_colors.dart';
import 'package:anipick/core/theme/app_text_styles.dart';
import 'package:anipick/features/auth/provider/auth_controller.dart';
import 'package:anipick/features/home/domain/entities/work.dart';
import 'package:anipick/features/home/presentation/controllers/home_controller.dart';
import 'package:anipick/features/home/presentation/states/home_ui_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'widgets/home_body.dart';
part 'widgets/glass_circle_button.dart';
part 'widgets/page_dots.dart';
part 'widgets/poster_item.dart';
part 'widgets/poster_row.dart';
part 'widgets/primary_pill_button.dart';
part 'widgets/season_header.dart';
part 'widgets/section_title_row.dart';
part 'widgets/top_hero_carousel.dart';

/// ホーム画面を表示
final class HomePage extends ConsumerWidget {
  /// 画面を作成
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final asyncState = ref.watch(homeControllerProvider);

    return AdaptiveScaffold(
      body: asyncState.when(
        skipLoadingOnReload: true,
        skipLoadingOnRefresh: true,
        data: (state) => _HomeBody(
          state: state,
          isAuthLoading: auth.isLoading,
          onReload: asyncState.isLoading
              ? null
              : () async {
                  await ref.read(homeControllerProvider.notifier).reload();
                },
          onSignOut: auth.isLoading
              ? null
              : () async {
                  await ref.read(authControllerProvider.notifier).signOut();
                },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) {
          final uiError = e is UiError
              ? e
              : const UiError(message: '予期しないエラーが発生しました');
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(uiError.message),
                  const SizedBox(height: 12),
                  AdaptiveButton.child(
                    onPressed: () async {
                      await ref.read(homeControllerProvider.notifier).reload();
                    },
                    child: const Text('再試行'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
