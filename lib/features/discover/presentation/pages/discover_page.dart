import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:anipick/core/auth/auth_session_controller.dart';
import 'package:anipick/core/error/ui_error.dart';
import 'package:anipick/core/theme/app_colors.dart';
import 'package:anipick/core/theme/app_text_styles.dart';
import 'package:anipick/features/discover/domain/entities/work.dart';
import 'package:anipick/features/discover/presentation/controllers/discover_controller.dart';
import 'package:anipick/features/discover/presentation/states/discover_ui_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'discover/widgets/discover_body.dart';
part 'discover/widgets/top_hero_carousel.dart';
part 'discover/widgets/primary_pill_button.dart';
part 'discover/widgets/glass_circle_button.dart';
part 'discover/widgets/page_dots.dart';
part 'discover/widgets/section_title_row.dart';
part 'discover/widgets/season_header.dart';
part 'discover/widgets/poster_row.dart';
part 'discover/widgets/poster_item.dart';

/// Discover（ホーム）画面を表示
final class DiscoverPage extends ConsumerWidget {
  /// 画面を作成
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authSessionControllerProvider);
    final asyncState = ref.watch(discoverControllerProvider);

    return AdaptiveScaffold(
      body: asyncState.when(
        skipLoadingOnReload: true,
        skipLoadingOnRefresh: true,
        data: (state) => _DiscoverBody(
          state: state,
          isAuthLoading: auth.isLoading,
          onReload: asyncState.isLoading
              ? null
              : () async {
                  await ref.read(discoverControllerProvider.notifier).reload();
                },
          onSignOut: auth.isLoading
              ? null
              : () async {
                  await ref
                      .read(authSessionControllerProvider.notifier)
                      .signOut();
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
                      await ref
                          .read(discoverControllerProvider.notifier)
                          .reload();
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
