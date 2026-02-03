/// ドメイン層で扱う失敗要因を表す
sealed class Failure {
  /// 失敗要因を作成
  const Failure();
}

/// 通信失敗を表す
final class NetworkFailure extends Failure {
  /// 失敗要因を作成
  const NetworkFailure();
}

/// 認証失敗を表す
final class UnauthorizedFailure extends Failure {
  /// 失敗要因を作成
  const UnauthorizedFailure();
}

/// 想定外の失敗を表す
final class UnexpectedFailure extends Failure {
  /// 失敗要因を作成
  const UnexpectedFailure();
}
