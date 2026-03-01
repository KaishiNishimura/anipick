import 'package:freezed_annotation/freezed_annotation.dart';

part 'access_token.freezed.dart';

/// アクセストークンを表す値オブジェクト
@freezed
abstract class AccessToken with _$AccessToken {
  /// 値を指定して作成
  const factory AccessToken(String value) = _AccessToken;
}
