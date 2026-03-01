import 'package:anipick/core/persistence/secure_storage_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_local_datasource.g.dart';

/// アクセストークンを安全領域へ永続化するローカルデータソース
final class AuthLocalDataSource {
  /// データソースを作成
  const AuthLocalDataSource(this._storage);

  static const _accessTokenKey = 'annict_access_token';

  final FlutterSecureStorage _storage;

  /// 保存済みアクセストークンを読み取り
  Future<String?> readAccessToken() => _storage.read(key: _accessTokenKey);

  /// アクセストークンを保存
  Future<void> writeAccessToken(String token) =>
      _storage.write(key: _accessTokenKey, value: token);

  /// 保存済みアクセストークンを削除
  Future<void> deleteAccessToken() => _storage.delete(key: _accessTokenKey);
}

/// 認証用ローカルデータソースを提供
@riverpod
AuthLocalDataSource authLocalDataSource(Ref ref) {
  final storage = ref.watch(secureStorageProvider);
  return AuthLocalDataSource(storage);
}
