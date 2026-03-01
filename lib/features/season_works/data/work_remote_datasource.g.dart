// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_remote_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 作品用リモートデータソースを提供

@ProviderFor(workRemoteDataSource)
final workRemoteDataSourceProvider = WorkRemoteDataSourceProvider._();

/// 作品用リモートデータソースを提供

final class WorkRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          WorkRemoteDataSource,
          WorkRemoteDataSource,
          WorkRemoteDataSource
        >
    with $Provider<WorkRemoteDataSource> {
  /// 作品用リモートデータソースを提供
  WorkRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<WorkRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WorkRemoteDataSource create(Ref ref) {
    return workRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkRemoteDataSource>(value),
    );
  }
}

String _$workRemoteDataSourceHash() =>
    r'53ddbf07a04bd67f61b10c1e55f02a592cc6edc0';
