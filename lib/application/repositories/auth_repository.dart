import 'package:anipick/core/error/failure.dart';
import 'package:anipick/domain/entities/access_token.dart';

/// 認証処理を抽象化するリポジトリを定義
abstract interface class AuthRepository {
  /// 保存済みアクセストークンを取得
  Future<AccessToken?> getSavedAccessToken();

  /// サインインしてアクセストークンを取得
  Future<(AccessToken?, Failure?)> signIn();

  /// サインアウトして保存済みトークンを削除
  Future<void> signOut();
}
