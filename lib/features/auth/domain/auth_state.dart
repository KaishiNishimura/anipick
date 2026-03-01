import 'package:anipick/features/auth/domain/access_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

/// 認証セッションの状態
@freezed
abstract class AuthState with _$AuthState {
  /// 状態を作成
  const factory AuthState({AccessToken? accessToken}) = _AuthState;

  const AuthState._();

  /// サインイン済みかどうかを判定
  bool get isSignedIn => accessToken != null;
}
