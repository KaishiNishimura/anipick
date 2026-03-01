import 'package:anipick/core/env/annict_env.dart';
import 'package:anipick/core/exceptions/app_exception.dart';
import 'package:anipick/core/network/http_exception.dart';
import 'package:anipick/features/auth/data/auth_local_datasource.dart';
import 'package:anipick/features/auth/data/auth_remote_datasource.dart';
import 'package:anipick/features/auth/domain/access_token.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

/// 認証リポジトリ
final class AuthRepository {
  /// リポジトリを作成
  const AuthRepository({
    required AuthRemoteDataSource remote,
    required AuthLocalDataSource local,
  }) : _remote = remote,
       _local = local;

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  /// 保存済みアクセストークンを取得
  Future<AccessToken?> getSavedAccessToken() async {
    final token = await _local.readAccessToken();
    if (token == null || token.isEmpty) {
      return null;
    }
    return AccessToken(token);
  }

  /// サインインしてアクセストークンを取得
  Future<AccessToken> signIn() async {
    if (AnnictEnv.clientId.isEmpty ||
        AnnictEnv.clientSecret.isEmpty ||
        AnnictEnv.redirectUri.isEmpty) {
      throw const UnexpectedException();
    }

    try {
      final code = await _remote.requestAuthorizationCode();
      final token = await _remote.exchangeAccessToken(code: code);
      await _local.writeAccessToken(token);
      return AccessToken(token);
    } on HttpException catch (e) {
      if (e.statusCode == 401) throw const UnauthorizedException();
      throw const NetworkException();
    } on AppException {
      rethrow;
    } on Exception {
      throw const UnexpectedException();
    }
  }

  /// サインアウトして保存済みトークンを削除
  Future<void> signOut() => _local.deleteAccessToken();
}

/// 認証リポジトリを提供
@riverpod
AuthRepository authRepository(Ref ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  final local = ref.watch(authLocalDataSourceProvider);
  return AuthRepository(remote: remote, local: local);
}
