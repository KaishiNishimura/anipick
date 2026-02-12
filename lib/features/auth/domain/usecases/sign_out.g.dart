// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_out.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// サインアウトユースケースを提供

@ProviderFor(signOut)
final signOutProvider = SignOutProvider._();

/// サインアウトユースケースを提供

final class SignOutProvider
    extends $FunctionalProvider<SignOutUseCase, SignOutUseCase, SignOutUseCase>
    with $Provider<SignOutUseCase> {
  /// サインアウトユースケースを提供
  SignOutProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signOutProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signOutHash();

  @$internal
  @override
  $ProviderElement<SignOutUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignOutUseCase create(Ref ref) {
    return signOut(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignOutUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignOutUseCase>(value),
    );
  }
}

String _$signOutHash() => r'a52ac5d77c13389400bd0f0cd26097ac0d7c88a1';
