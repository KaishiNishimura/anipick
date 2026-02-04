import 'package:anipick/core/network/http_client_provider.dart';
import 'package:anipick/core/persistence/secure_storage_provider.dart';
import 'package:anipick/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:anipick/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:anipick/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:anipick/features/auth/domain/repositories/auth_repository.dart';
import 'package:anipick/features/auth/domain/usecases/get_saved_access_token.dart';
import 'package:anipick/features/auth/domain/usecases/sign_in.dart';
import 'package:anipick/features/auth/domain/usecases/sign_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

/// 認証用リモートデータソースを提供
@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final client = ref.watch(httpClientProvider);
  return AuthRemoteDataSource(client);
}

/// 認証用ローカルデータソースを提供
@riverpod
AuthLocalDataSource authLocalDataSource(Ref ref) {
  final storage = ref.watch(secureStorageProvider);
  return AuthLocalDataSource(storage);
}

/// 認証リポジトリを提供
@riverpod
AuthRepository authRepository(Ref ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  final local = ref.watch(authLocalDataSourceProvider);
  return AuthRepositoryImpl(remote: remote, local: local);
}

/// 保存済みアクセストークン取得ユースケースを提供
@riverpod
GetSavedAccessTokenUseCase getSavedAccessToken(Ref ref) {
  final repo = ref.watch(authRepositoryProvider);
  return GetSavedAccessTokenUseCase(repo);
}

/// サインインユースケースを提供
@riverpod
SignInUseCase signIn(Ref ref) {
  final repo = ref.watch(authRepositoryProvider);
  return SignInUseCase(repo);
}

/// サインアウトユースケースを提供
@riverpod
SignOutUseCase signOut(Ref ref) {
  final repo = ref.watch(authRepositoryProvider);
  return SignOutUseCase(repo);
}
