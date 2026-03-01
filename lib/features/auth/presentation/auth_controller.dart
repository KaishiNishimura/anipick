import 'package:anipick/features/auth/data/auth_repository.dart';
import 'package:anipick/features/auth/domain/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

/// 認証セッション（横断状態）を管理する Controller
@Riverpod(keepAlive: true)
final class AuthController extends _$AuthController {
  @override
  Future<AuthState> build() async {
    final repo = ref.read(authRepositoryProvider);
    final token = await repo.getSavedAccessToken();
    return AuthState(accessToken: token);
  }

  /// サインインを実行
  Future<void> signIn() async {
    final repo = ref.read(authRepositoryProvider);
    final token = await repo.signIn();
    state = AsyncData(AuthState(accessToken: token));
  }

  /// サインアウトを実行
  Future<void> signOut() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.signOut();
    state = const AsyncData(AuthState());
  }
}
