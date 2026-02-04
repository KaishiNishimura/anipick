import 'package:anipick/core/network/http_client_provider.dart';
import 'package:anipick/features/discover/data/datasources/remote/work_remote_datasource.dart';
import 'package:anipick/features/discover/data/repositories/work_repository_impl.dart';
import 'package:anipick/features/discover/domain/repositories/work_repository.dart';
import 'package:anipick/features/discover/domain/usecases/get_season_works.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 作品用リモートデータソースを提供
final workRemoteDataSourceProvider = Provider<WorkRemoteDataSource>((ref) {
  final client = ref.watch(httpClientProvider);
  return WorkRemoteDataSource(client);
});

/// 作品リポジトリを提供
final workRepositoryProvider = Provider<WorkRepository>((ref) {
  final remote = ref.watch(workRemoteDataSourceProvider);
  return WorkRepositoryImpl(remote: remote);
});

/// シーズン作品一覧取得ユースケースを提供
final getSeasonWorksProvider = Provider<GetSeasonWorksUseCase>((ref) {
  final repo = ref.watch(workRepositoryProvider);
  return GetSeasonWorksUseCase(repo);
});
