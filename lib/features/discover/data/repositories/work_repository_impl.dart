import 'package:anipick/core/error/failure.dart';
import 'package:anipick/features/discover/data/datasources/remote/work_remote_datasource.dart';
import 'package:anipick/features/discover/data/dtos/work_dto.dart';
import 'package:anipick/features/discover/domain/entities/work.dart';
import 'package:anipick/features/discover/domain/repositories/work_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'work_repository_impl.g.dart';

/// 作品情報リポジトリの実装
final class WorkRepositoryImpl implements WorkRepository {
  /// リポジトリを作成
  const WorkRepositoryImpl({required WorkRemoteDataSource remote})
    : _remote = remote;

  /// リモートデータソースを保持
  final WorkRemoteDataSource _remote;

  @override
  Future<(List<Work>?, Failure?)> getWorksBySeason({
    required String season,
    required String accessToken,
    int perPage = 50,
  }) async {
    try {
      final json = await _remote.fetchWorksBySeason(
        season: season,
        accessToken: accessToken,
        perPage: perPage,
      );

      final worksJson = json['works'];
      if (worksJson is! List) {
        return (null, const UnexpectedFailure());
      }

      final works =
          worksJson
              .whereType<Map<String, dynamic>>()
              .map(WorkDto.fromJson)
              .map((dto) => dto.toEntity())
              .toList()
            ..sort((a, b) => b.watchersCount.compareTo(a.watchersCount));

      return (works, null);
    } on HttpException catch (e) {
      if (e.statusCode == 401) {
        return (null, const UnauthorizedFailure());
      }
      return (null, const NetworkFailure());
    } on Exception {
      return (null, const UnexpectedFailure());
    }
  }

  @override
  Future<(Work?, Failure?)> getWorkById({
    required int workId,
    required String accessToken,
  }) async {
    try {
      final json = await _remote.fetchWorksByIds(
        workIds: <int>[workId],
        accessToken: accessToken,
      );

      final worksJson = json['works'];
      if (worksJson is! List) {
        return (null, const UnexpectedFailure());
      }

      final works = worksJson
          .whereType<Map<String, dynamic>>()
          .map(WorkDto.fromJson)
          .map((dto) => dto.toEntity())
          .toList();

      if (works.isEmpty) {
        return (null, const UnexpectedFailure());
      }

      return (works.first, null);
    } on HttpException catch (e) {
      if (e.statusCode == 401) {
        return (null, const UnauthorizedFailure());
      }
      return (null, const NetworkFailure());
    } on Exception {
      return (null, const UnexpectedFailure());
    }
  }
}

/// 作品リポジトリを提供
@riverpod
WorkRepository workRepository(Ref ref) {
  final remote = ref.watch(workRemoteDataSourceProvider);
  return WorkRepositoryImpl(remote: remote);
}
