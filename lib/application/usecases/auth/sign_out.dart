import 'package:anipick/application/repositories/auth_repository.dart';
import 'package:anipick/infrastructure/repositories/auth_repository_impl.dart';
import 'package:anipick/provider/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_out.g.dart';

/// サインアウトして保存済みトークンを削除するユースケースを定義
final class SignOutUseCase {
  /// ユースケースを作成
  const SignOutUseCase(this._controller, this._repository);

  /// 認証リポジトリを保持
  final AuthController _controller;
  final AuthRepository _repository;

  /// サインアウトを実行
  Future<void> call() async {
    await _repository.signOut();
    _controller.updateAccessToken(null);
  }
}

/// サインアウトユースケースを提供
@riverpod
SignOutUseCase signOutUseCase(Ref ref) {
  final repo = ref.watch(authRepositoryProvider);
  final controller = ref.watch(authControllerProvider.notifier);
  return SignOutUseCase(controller, repo);
}
