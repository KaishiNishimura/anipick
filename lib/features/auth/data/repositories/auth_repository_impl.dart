import 'package:anipick/core/env/annict_env.dart';
import 'package:anipick/core/error/failure.dart';
import 'package:anipick/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:anipick/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:anipick/features/auth/domain/entities/access_token.dart';
import 'package:anipick/features/auth/domain/repositories/auth_repository.dart';

/// 認証リポジトリの実装
class AuthRepositoryImpl implements AuthRepository {
  /// リポジトリを作成
  const AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required AuthLocalDataSource local,
  }) : _remote = remote,
       _local = local;

  /// リモートデータソースを保持
  final AuthRemoteDataSource _remote;

  /// ローカルデータソースを保持
  final AuthLocalDataSource _local;

  @override
  /// 保存済みアクセストークンを取得
  Future<AccessToken?> getSavedAccessToken() async {
    final token = await _local.readAccessToken();
    if (token == null || token.isEmpty) {
      return null;
    }
    return AccessToken(token);
  }

  @override
  /// サインインしてアクセストークンを取得
  Future<(AccessToken?, Failure?)> signIn() async {
    if (AnnictEnv.clientId.isEmpty ||
        AnnictEnv.clientSecret.isEmpty ||
        AnnictEnv.redirectUri.isEmpty) {
      return (null, const UnexpectedFailure());
    }

    try {
      final code = await _remote.requestAuthorizationCode();
      final token = await _remote.exchangeAccessToken(code: code);
      await _local.writeAccessToken(token);
      return (AccessToken(token), null);
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
  /// サインアウトして保存済みトークンを削除
  Future<void> signOut() => _local.deleteAccessToken();
}
