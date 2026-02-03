import 'package:anipick/features/auth/domain/entities/access_token.dart';
import 'package:anipick/features/auth/domain/repositories/auth_repository.dart';

/// 保存済みアクセストークンを取得するユースケースを定義
class GetSavedAccessTokenUseCase {
  /// ユースケースを作成
  const GetSavedAccessTokenUseCase(this._repository);

  /// 認証リポジトリを保持
  final AuthRepository _repository;

  /// 保存済みアクセストークンを取得
  Future<AccessToken?> call() => _repository.getSavedAccessToken();
}
