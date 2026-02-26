import 'package:anipick/application/repositories/work_repository.dart';
import 'package:anipick/core/error/failure.dart';
import 'package:anipick/domain/entities/work.dart';
import 'package:anipick/infrastructure/repositories/work_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_season_works.g.dart';

/// シーズン作品一覧を取得するユースケースを定義
final class GetSeasonWorksUseCase {
  /// ユースケースを作成
  const GetSeasonWorksUseCase(this._repository);

  /// リポジトリを保持
  final WorkRepository _repository;

  /// シーズン作品一覧を取得
  Future<(List<Work>?, Failure?)> call({
    required String season,
    required String accessToken,
    int perPage = 50,
  }) => _repository.getWorksBySeason(
    season: season,
    accessToken: accessToken,
    perPage: perPage,
  );
}

/// シーズン作品一覧取得ユースケースを提供
@riverpod
GetSeasonWorksUseCase getSeasonWorks(Ref ref) {
  final repo = ref.watch(workRepositoryProvider);
  return GetSeasonWorksUseCase(repo);
}
