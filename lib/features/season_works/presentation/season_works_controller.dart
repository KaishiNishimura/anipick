import 'package:anipick/core/exceptions/app_exception.dart';
import 'package:anipick/features/auth/presentation/auth_controller.dart';
import 'package:anipick/features/season_works/data/work_repository.dart';
import 'package:anipick/features/season_works/domain/season_works.dart';
import 'package:anipick/features/season_works/domain/season_works_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'season_works_controller.g.dart';

/// シーズン作品の状態を管理
@riverpod
final class SeasonWorksController extends _$SeasonWorksController {
  @override
  Future<SeasonWorks> build(int back) async {
    final auth = await ref.watch(authControllerProvider.future);
    final token = auth.accessToken?.value;
    if (token == null || token.isEmpty) {
      throw const UnauthorizedException();
    }

    final service = ref.read(seasonWorksServiceProvider);
    final seasonName = service.getSeasonName(back);

    final repository = ref.read(workRepositoryProvider);
    final works = await repository.getWorksBySeason(
      season: seasonName,
      accessToken: token,
    );

    final seasonText = works.isEmpty ? seasonName : works.first.seasonNameText;

    return SeasonWorks(
      season: seasonName,
      seasonText: seasonText,
      works: works,
    );
  }
}
