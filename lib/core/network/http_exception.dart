/// HTTP エラーを表す例外
final class HttpException implements Exception {
  /// 例外を作成
  const HttpException(this.statusCode);

  /// HTTP ステータスコードを保持
  final int statusCode;
}
