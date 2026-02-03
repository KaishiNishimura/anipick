import 'package:anipick/core/error/failure.dart';
import 'package:anipick/features/discover/domain/entities/work.dart';
import 'package:anipick/features/discover/domain/repositories/work_repository.dart';

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
