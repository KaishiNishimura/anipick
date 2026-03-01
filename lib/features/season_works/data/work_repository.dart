import 'package:anipick/core/exceptions/app_exception.dart';
import 'package:anipick/core/network/http_exception.dart';
import 'package:anipick/features/season_works/data/work_remote_datasource.dart';
import 'package:anipick/features/season_works/domain/work.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'work_repository.g.dart';

/// 作品情報リポジトリ
final class WorkRepository {
  /// リポジトリを作成
  const WorkRepository({required WorkRemoteDataSource remote})
    : _remote = remote;

  final WorkRemoteDataSource _remote;

  /// 指定シーズンの作品一覧を取得
  Future<List<Work>> getWorksBySeason({
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
        throw const UnexpectedException();
      }

      return worksJson
          .whereType<Map<String, dynamic>>()
          .map(Work.fromJson)
          .toList()
        ..sort((a, b) => b.watchersCount.compareTo(a.watchersCount));
    } on HttpException catch (e) {
      if (e.statusCode == 401) throw const UnauthorizedException();
      throw const NetworkException();
    } on AppException {
      rethrow;
    } on Exception {
      throw const UnexpectedException();
    }
  }

  /// 作品IDから作品を取得
  Future<Work> getWorkById({
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
        throw const UnexpectedException();
      }

      final works = worksJson
          .whereType<Map<String, dynamic>>()
          .map(Work.fromJson)
          .toList();

      if (works.isEmpty) {
        throw const UnexpectedException();
      }

      return works.first;
    } on HttpException catch (e) {
      if (e.statusCode == 401) throw const UnauthorizedException();
      throw const NetworkException();
    } on AppException {
      rethrow;
    } on Exception {
      throw const UnexpectedException();
    }
  }
}

/// 作品リポジトリを提供
@riverpod
WorkRepository workRepository(Ref ref) {
  final remote = ref.watch(workRemoteDataSourceProvider);
  return WorkRepository(remote: remote);
}
