import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:anipick/application/usecases/auth/sign_out.dart';
import 'package:anipick/application/usecases/home/refresh_season_works.dart';
import 'package:anipick/core/theme/app_colors.dart';
import 'package:anipick/core/theme/app_text_styles.dart';
import 'package:anipick/domain/entities/work.dart';
import 'package:anipick/provider/season_works_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'widgets/glass_circle_button.dart';
part 'widgets/home_body.dart';
part 'widgets/home_content.dart';
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
    return AdaptiveScaffold(
      body: _HomeBody(),
    );
  }
}
