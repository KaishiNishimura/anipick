import 'package:anipick/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:anipick/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_out.g.dart';

/// サインアウトして保存済みトークンを削除するユースケースを定義
final class SignOutUseCase {
  /// ユースケースを作成
  const SignOutUseCase(this._repository);

  /// 認証リポジトリを保持
  final AuthRepository _repository;

  /// サインアウトを実行
  Future<void> call() => _repository.signOut();
}

/// サインアウトユースケースを提供
@riverpod
SignOutUseCase signOut(Ref ref) {
  final repo = ref.watch(authRepositoryProvider);
  return SignOutUseCase(repo);
}
