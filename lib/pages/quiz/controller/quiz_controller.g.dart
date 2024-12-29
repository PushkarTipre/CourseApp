// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$startQuizControllerHash() =>
    r'86c3290f771c4f24898e26e8f0b252e94a327d94';

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

/// See also [startQuizController].
@ProviderFor(startQuizController)
const startQuizControllerProvider = StartQuizControllerFamily();

/// See also [startQuizController].
class StartQuizControllerFamily extends Family<AsyncValue<QuizStartItem?>> {
  /// See also [startQuizController].
  const StartQuizControllerFamily();

  /// See also [startQuizController].
  StartQuizControllerProvider call({
    required QuizStartRequestEntity params,
  }) {
    return StartQuizControllerProvider(
      params: params,
    );
  }

  @override
  StartQuizControllerProvider getProviderOverride(
    covariant StartQuizControllerProvider provider,
  ) {
    return call(
      params: provider.params,
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
  String? get name => r'startQuizControllerProvider';
}

/// See also [startQuizController].
class StartQuizControllerProvider
    extends AutoDisposeFutureProvider<QuizStartItem?> {
  /// See also [startQuizController].
  StartQuizControllerProvider({
    required QuizStartRequestEntity params,
  }) : this._internal(
          (ref) => startQuizController(
            ref as StartQuizControllerRef,
            params: params,
          ),
          from: startQuizControllerProvider,
          name: r'startQuizControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$startQuizControllerHash,
          dependencies: StartQuizControllerFamily._dependencies,
          allTransitiveDependencies:
              StartQuizControllerFamily._allTransitiveDependencies,
          params: params,
        );

  StartQuizControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.params,
  }) : super.internal();

  final QuizStartRequestEntity params;

  @override
  Override overrideWith(
    FutureOr<QuizStartItem?> Function(StartQuizControllerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StartQuizControllerProvider._internal(
        (ref) => create(ref as StartQuizControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        params: params,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<QuizStartItem?> createElement() {
    return _StartQuizControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StartQuizControllerProvider && other.params == params;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StartQuizControllerRef on AutoDisposeFutureProviderRef<QuizStartItem?> {
  /// The parameter `params` of this provider.
  QuizStartRequestEntity get params;
}

class _StartQuizControllerProviderElement
    extends AutoDisposeFutureProviderElement<QuizStartItem?>
    with StartQuizControllerRef {
  _StartQuizControllerProviderElement(super.provider);

  @override
  QuizStartRequestEntity get params =>
      (origin as StartQuizControllerProvider).params;
}

String _$submitQuizControllerHash() =>
    r'eaa633dae2447b9d9011f564d672245103a09ad6';

/// See also [submitQuizController].
@ProviderFor(submitQuizController)
const submitQuizControllerProvider = SubmitQuizControllerFamily();

/// See also [submitQuizController].
class SubmitQuizControllerFamily extends Family<AsyncValue<QuizSubmitItem?>> {
  /// See also [submitQuizController].
  const SubmitQuizControllerFamily();

  /// See also [submitQuizController].
  SubmitQuizControllerProvider call({
    required QuizSubmitRequestEntity params,
  }) {
    return SubmitQuizControllerProvider(
      params: params,
    );
  }

  @override
  SubmitQuizControllerProvider getProviderOverride(
    covariant SubmitQuizControllerProvider provider,
  ) {
    return call(
      params: provider.params,
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
  String? get name => r'submitQuizControllerProvider';
}

/// See also [submitQuizController].
class SubmitQuizControllerProvider
    extends AutoDisposeFutureProvider<QuizSubmitItem?> {
  /// See also [submitQuizController].
  SubmitQuizControllerProvider({
    required QuizSubmitRequestEntity params,
  }) : this._internal(
          (ref) => submitQuizController(
            ref as SubmitQuizControllerRef,
            params: params,
          ),
          from: submitQuizControllerProvider,
          name: r'submitQuizControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$submitQuizControllerHash,
          dependencies: SubmitQuizControllerFamily._dependencies,
          allTransitiveDependencies:
              SubmitQuizControllerFamily._allTransitiveDependencies,
          params: params,
        );

  SubmitQuizControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.params,
  }) : super.internal();

  final QuizSubmitRequestEntity params;

  @override
  Override overrideWith(
    FutureOr<QuizSubmitItem?> Function(SubmitQuizControllerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubmitQuizControllerProvider._internal(
        (ref) => create(ref as SubmitQuizControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        params: params,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<QuizSubmitItem?> createElement() {
    return _SubmitQuizControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubmitQuizControllerProvider && other.params == params;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SubmitQuizControllerRef on AutoDisposeFutureProviderRef<QuizSubmitItem?> {
  /// The parameter `params` of this provider.
  QuizSubmitRequestEntity get params;
}

class _SubmitQuizControllerProviderElement
    extends AutoDisposeFutureProviderElement<QuizSubmitItem?>
    with SubmitQuizControllerRef {
  _SubmitQuizControllerProviderElement(super.provider);

  @override
  QuizSubmitRequestEntity get params =>
      (origin as SubmitQuizControllerProvider).params;
}

String _$getQuizResultControllerHash() =>
    r'92e2db2d3ec638e2fbe0e258d98b2c14394654dd';

/// See also [getQuizResultController].
@ProviderFor(getQuizResultController)
const getQuizResultControllerProvider = GetQuizResultControllerFamily();

/// See also [getQuizResultController].
class GetQuizResultControllerFamily
    extends Family<AsyncValue<QuizResultItem?>> {
  /// See also [getQuizResultController].
  const GetQuizResultControllerFamily();

  /// See also [getQuizResultController].
  GetQuizResultControllerProvider call({
    required String uniqueId,
  }) {
    return GetQuizResultControllerProvider(
      uniqueId: uniqueId,
    );
  }

  @override
  GetQuizResultControllerProvider getProviderOverride(
    covariant GetQuizResultControllerProvider provider,
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
  String? get name => r'getQuizResultControllerProvider';
}

/// See also [getQuizResultController].
class GetQuizResultControllerProvider
    extends AutoDisposeFutureProvider<QuizResultItem?> {
  /// See also [getQuizResultController].
  GetQuizResultControllerProvider({
    required String uniqueId,
  }) : this._internal(
          (ref) => getQuizResultController(
            ref as GetQuizResultControllerRef,
            uniqueId: uniqueId,
          ),
          from: getQuizResultControllerProvider,
          name: r'getQuizResultControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getQuizResultControllerHash,
          dependencies: GetQuizResultControllerFamily._dependencies,
          allTransitiveDependencies:
              GetQuizResultControllerFamily._allTransitiveDependencies,
          uniqueId: uniqueId,
        );

  GetQuizResultControllerProvider._internal(
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
    FutureOr<QuizResultItem?> Function(GetQuizResultControllerRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetQuizResultControllerProvider._internal(
        (ref) => create(ref as GetQuizResultControllerRef),
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
  AutoDisposeFutureProviderElement<QuizResultItem?> createElement() {
    return _GetQuizResultControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetQuizResultControllerProvider &&
        other.uniqueId == uniqueId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uniqueId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetQuizResultControllerRef
    on AutoDisposeFutureProviderRef<QuizResultItem?> {
  /// The parameter `uniqueId` of this provider.
  String get uniqueId;
}

class _GetQuizResultControllerProviderElement
    extends AutoDisposeFutureProviderElement<QuizResultItem?>
    with GetQuizResultControllerRef {
  _GetQuizResultControllerProviderElement(super.provider);

  @override
  String get uniqueId => (origin as GetQuizResultControllerProvider).uniqueId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
