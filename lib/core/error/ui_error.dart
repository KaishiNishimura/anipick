/// UI に表示するエラー情報を表す
class UiError {
  /// エラー情報を作成
  const UiError({required this.message, this.canRetry = true});

  /// 表示メッセージを保持
  final String message;

  /// リトライ可否を保持
  final bool canRetry;
}
