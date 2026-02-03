import 'package:anipick/features/auth/domain/repositories/auth_repository.dart';

/// サインアウトして保存済みトークンを削除するユースケースを定義
class SignOutUseCase {
  /// ユースケースを作成
  const SignOutUseCase(this._repository);

  /// 認証リポジトリを保持
  final AuthRepository _repository;

  /// サインアウトを実行
  Future<void> call() => _repository.signOut();
}
