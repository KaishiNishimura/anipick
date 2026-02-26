// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_season_works.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// シーズン作品一覧取得ユースケースを提供

@ProviderFor(getSeasonWorksUseCase)
final getSeasonWorksUseCaseProvider = GetSeasonWorksUseCaseProvider._();

/// シーズン作品一覧取得ユースケースを提供

final class GetSeasonWorksUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetSeasonWorksUseCase>,
          GetSeasonWorksUseCase,
          FutureOr<GetSeasonWorksUseCase>
        >
    with
        $FutureModifier<GetSeasonWorksUseCase>,
        $FutureProvider<GetSeasonWorksUseCase> {
  /// シーズン作品一覧取得ユースケースを提供
  GetSeasonWorksUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSeasonWorksUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSeasonWorksUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetSeasonWorksUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetSeasonWorksUseCase> create(Ref ref) {
    return getSeasonWorksUseCase(ref);
  }
}

String _$getSeasonWorksUseCaseHash() =>
    r'2da938b6f5062a943b704b3e2fabb222da4da39f';
