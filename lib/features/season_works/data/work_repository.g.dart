// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 作品リポジトリを提供

@ProviderFor(workRepository)
final workRepositoryProvider = WorkRepositoryProvider._();

/// 作品リポジトリを提供

final class WorkRepositoryProvider
    extends $FunctionalProvider<WorkRepository, WorkRepository, WorkRepository>
    with $Provider<WorkRepository> {
  /// 作品リポジトリを提供
  WorkRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workRepositoryHash();

  @$internal
  @override
  $ProviderElement<WorkRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WorkRepository create(Ref ref) {
    return workRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkRepository>(value),
    );
  }
}

String _$workRepositoryHash() => r'e29f170474b95604bb2d6f0dbe55a388806e2ea9';
