// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_season_works.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// シーズン作品一覧取得ユースケースを提供

@ProviderFor(refreshSeasonWorksUseCase)
final refreshSeasonWorksUseCaseProvider = RefreshSeasonWorksUseCaseProvider._();

/// シーズン作品一覧取得ユースケースを提供

final class RefreshSeasonWorksUseCaseProvider
    extends
        $FunctionalProvider<
          RefreshSeasonWorksUseCase,
          RefreshSeasonWorksUseCase,
          RefreshSeasonWorksUseCase
        >
    with $Provider<RefreshSeasonWorksUseCase> {
  /// シーズン作品一覧取得ユースケースを提供
  RefreshSeasonWorksUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'refreshSeasonWorksUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$refreshSeasonWorksUseCaseHash();

  @$internal
  @override
  $ProviderElement<RefreshSeasonWorksUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RefreshSeasonWorksUseCase create(Ref ref) {
    return refreshSeasonWorksUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RefreshSeasonWorksUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RefreshSeasonWorksUseCase>(value),
    );
  }
}

String _$refreshSeasonWorksUseCaseHash() =>
    r'91a9a0d7a23eb46db5c2bdbfd9ed4ef2727d293e';
