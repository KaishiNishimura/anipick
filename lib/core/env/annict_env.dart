/// Annict API の環境変数設定をまとめて管理
final class AnnictEnv {
  /// ユーティリティクラスとして利用
  const AnnictEnv._();

  /// OAuth クライアントIDを取得
  static const clientId = String.fromEnvironment('ANNICT_CLIENT_ID');

  /// OAuth クライアントシークレットを取得
  static const clientSecret = String.fromEnvironment('ANNICT_CLIENT_SECRET');

  /// Annict側で登録した redirect_uri と一致させること
  /// 例: anipick://oauth-callback
  /// OAuth リダイレクトURIを取得
  static const redirectUri = String.fromEnvironment('ANNICT_REDIRECT_URI');

  /// 例: read write
  /// OAuth スコープを取得
  static const scope = String.fromEnvironment(
    'ANNICT_SCOPE',
    defaultValue: 'read write',
  );

  /// 認可エンドポイントを保持
  static const authorizeEndpoint = 'https://annict.com/oauth/authorize';

  /// トークンエンドポイントを保持
  static const tokenEndpoint = 'https://api.annict.com/oauth/token';
}
