import 'package:anipick/application/usecases/home/get_season_works.dart';
import 'package:anipick/domain/entities/season_works.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'season_works_controller.g.dart';

/// Home画面の状態を管理
@riverpod
final class SeasonWorksController extends _$SeasonWorksController {
  @override
  Future<SeasonWorks> build(int back) async {
    final usecase = await ref.read(getSeasonWorksUseCaseProvider.future);
    return usecase(back);
  }
}
