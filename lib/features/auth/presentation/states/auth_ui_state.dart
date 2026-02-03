import 'package:anipick/features/auth/domain/entities/access_token.dart';

/// UI 層で扱う認証状態を表す
final class AuthUiState {
  /// 認証状態を作成
  const AuthUiState({required this.accessToken});

  /// サインイン済みの場合に保持するアクセストークン
  final AccessToken? accessToken;

  /// サインイン済みかどうかを判定
  bool get isSignedIn => accessToken != null;
}
