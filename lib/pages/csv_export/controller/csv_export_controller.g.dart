// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'csv_export_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$csvExportQuizResultControllerHash() =>
    r'798c351c732cb76bdd9ae46b10a3886380f91ccd';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [csvExportQuizResultController].
@ProviderFor(csvExportQuizResultController)
const csvExportQuizResultControllerProvider =
    CsvExportQuizResultControllerFamily();

/// See also [csvExportQuizResultController].
class CsvExportQuizResultControllerFamily
    extends Family<AsyncValue<List<AllQuizResultData>?>> {
  /// See also [csvExportQuizResultController].
  const CsvExportQuizResultControllerFamily();

  /// See also [csvExportQuizResultController].
  CsvExportQuizResultControllerProvider call({
    required String uniqueId,
  }) {
    return CsvExportQuizResultControllerProvider(
      uniqueId: uniqueId,
    );
  }

  @override
  CsvExportQuizResultControllerProvider getProviderOverride(
    covariant CsvExportQuizResultControllerProvider provider,
  ) {
    return call(
      uniqueId: provider.uniqueId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'csvExportQuizResultControllerProvider';
}

/// See also [csvExportQuizResultController].
class CsvExportQuizResultControllerProvider
    extends AutoDisposeFutureProvider<List<AllQuizResultData>?> {
  /// See also [csvExportQuizResultController].
  CsvExportQuizResultControllerProvider({
    required String uniqueId,
  }) : this._internal(
          (ref) => csvExportQuizResultController(
            ref as CsvExportQuizResultControllerRef,
            uniqueId: uniqueId,
          ),
          from: csvExportQuizResultControllerProvider,
          name: r'csvExportQuizResultControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$csvExportQuizResultControllerHash,
          dependencies: CsvExportQuizResultControllerFamily._dependencies,
          allTransitiveDependencies:
              CsvExportQuizResultControllerFamily._allTransitiveDependencies,
          uniqueId: uniqueId,
        );

  CsvExportQuizResultControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uniqueId,
  }) : super.internal();

  final String uniqueId;

  @override
  Override overrideWith(
    FutureOr<List<AllQuizResultData>?> Function(
            CsvExportQuizResultControllerRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CsvExportQuizResultControllerProvider._internal(
        (ref) => create(ref as CsvExportQuizResultControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uniqueId: uniqueId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AllQuizResultData>?> createElement() {
    return _CsvExportQuizResultControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CsvExportQuizResultControllerProvider &&
        other.uniqueId == uniqueId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uniqueId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CsvExportQuizResultControllerRef
    on AutoDisposeFutureProviderRef<List<AllQuizResultData>?> {
  /// The parameter `uniqueId` of this provider.
  String get uniqueId;
}

class _CsvExportQuizResultControllerProviderElement
    extends AutoDisposeFutureProviderElement<List<AllQuizResultData>?>
    with CsvExportQuizResultControllerRef {
  _CsvExportQuizResultControllerProviderElement(super.provider);

  @override
  String get uniqueId =>
      (origin as CsvExportQuizResultControllerProvider).uniqueId;
}

String _$csvUploadControllerHash() =>
    r'0addd2f4deb828f447698f5ae7a831a10fba009e';

/// See also [csvUploadController].
@ProviderFor(csvUploadController)
const csvUploadControllerProvider = CsvUploadControllerFamily();

/// See also [csvUploadController].
class CsvUploadControllerFamily
    extends Family<AsyncValue<Map<String, dynamic>?>> {
  /// See also [csvUploadController].
  const CsvUploadControllerFamily();

  /// See also [csvUploadController].
  CsvUploadControllerProvider call({
    required File csvFile,
    required String userId,
    Map<String, dynamic>? additionalData,
  }) {
    return CsvUploadControllerProvider(
      csvFile: csvFile,
      userId: userId,
      additionalData: additionalData,
    );
  }

  @override
  CsvUploadControllerProvider getProviderOverride(
    covariant CsvUploadControllerProvider provider,
  ) {
    return call(
      csvFile: provider.csvFile,
      userId: provider.userId,
      additionalData: provider.additionalData,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'csvUploadControllerProvider';
}

/// See also [csvUploadController].
class CsvUploadControllerProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>?> {
  /// See also [csvUploadController].
  CsvUploadControllerProvider({
    required File csvFile,
    required String userId,
    Map<String, dynamic>? additionalData,
  }) : this._internal(
          (ref) => csvUploadController(
            ref as CsvUploadControllerRef,
            csvFile: csvFile,
            userId: userId,
            additionalData: additionalData,
          ),
          from: csvUploadControllerProvider,
          name: r'csvUploadControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$csvUploadControllerHash,
          dependencies: CsvUploadControllerFamily._dependencies,
          allTransitiveDependencies:
              CsvUploadControllerFamily._allTransitiveDependencies,
          csvFile: csvFile,
          userId: userId,
          additionalData: additionalData,
        );

  CsvUploadControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.csvFile,
    required this.userId,
    required this.additionalData,
  }) : super.internal();

  final File csvFile;
  final String userId;
  final Map<String, dynamic>? additionalData;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>?> Function(CsvUploadControllerRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CsvUploadControllerProvider._internal(
        (ref) => create(ref as CsvUploadControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        csvFile: csvFile,
        userId: userId,
        additionalData: additionalData,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>?> createElement() {
    return _CsvUploadControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CsvUploadControllerProvider &&
        other.csvFile == csvFile &&
        other.userId == userId &&
        other.additionalData == additionalData;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, csvFile.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, additionalData.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CsvUploadControllerRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>?> {
  /// The parameter `csvFile` of this provider.
  File get csvFile;

  /// The parameter `userId` of this provider.
  String get userId;

  /// The parameter `additionalData` of this provider.
  Map<String, dynamic>? get additionalData;
}

class _CsvUploadControllerProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>?>
    with CsvUploadControllerRef {
  _CsvUploadControllerProviderElement(super.provider);

  @override
  File get csvFile => (origin as CsvUploadControllerProvider).csvFile;
  @override
  String get userId => (origin as CsvUploadControllerProvider).userId;
  @override
  Map<String, dynamic>? get additionalData =>
      (origin as CsvUploadControllerProvider).additionalData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
