// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// サインインユースケースを提供

@ProviderFor(signIn)
final signInProvider = SignInProvider._();

/// サインインユースケースを提供

final class SignInProvider
    extends $FunctionalProvider<SignInUseCase, SignInUseCase, SignInUseCase>
    with $Provider<SignInUseCase> {
  /// サインインユースケースを提供
  SignInProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signInProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signInHash();

  @$internal
  @override
  $ProviderElement<SignInUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignInUseCase create(Ref ref) {
    return signIn(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignInUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignInUseCase>(value),
    );
  }
}

String _$signInHash() => r'f55db1b32d2d8d4fb7cce2ffc094d6b8a396fb68';
