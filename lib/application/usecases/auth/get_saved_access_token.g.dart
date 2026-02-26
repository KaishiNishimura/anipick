// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_saved_access_token.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 保存済みアクセストークン取得ユースケースを提供

@ProviderFor(getSavedAccessToken)
final getSavedAccessTokenProvider = GetSavedAccessTokenProvider._();

/// 保存済みアクセストークン取得ユースケースを提供

final class GetSavedAccessTokenProvider
    extends
        $FunctionalProvider<
          GetSavedAccessTokenUseCase,
          GetSavedAccessTokenUseCase,
          GetSavedAccessTokenUseCase
        >
    with $Provider<GetSavedAccessTokenUseCase> {
  /// 保存済みアクセストークン取得ユースケースを提供
  GetSavedAccessTokenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSavedAccessTokenProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSavedAccessTokenHash();

  @$internal
  @override
  $ProviderElement<GetSavedAccessTokenUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetSavedAccessTokenUseCase create(Ref ref) {
    return getSavedAccessToken(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetSavedAccessTokenUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetSavedAccessTokenUseCase>(value),
    );
  }
}

String _$getSavedAccessTokenHash() =>
    r'72fd805189b90e1bd45cf7bdf729bfb822bb6991';
