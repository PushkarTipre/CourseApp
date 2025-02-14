// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mycourses_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myCoursesControllerHash() =>
    r'ddaa5582bc31e0833d85d04fb43d9c13d82c0438';

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

/// See also [myCoursesController].
@ProviderFor(myCoursesController)
const myCoursesControllerProvider = MyCoursesControllerFamily();

/// See also [myCoursesController].
class MyCoursesControllerFamily
    extends Family<AsyncValue<List<CoursePurchaseData>?>> {
  /// See also [myCoursesController].
  const MyCoursesControllerFamily();

  /// See also [myCoursesController].
  MyCoursesControllerProvider call({
    required String userToken,
  }) {
    return MyCoursesControllerProvider(
      userToken: userToken,
    );
  }

  @override
  MyCoursesControllerProvider getProviderOverride(
    covariant MyCoursesControllerProvider provider,
  ) {
    return call(
      userToken: provider.userToken,
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
  String? get name => r'myCoursesControllerProvider';
}

/// See also [myCoursesController].
class MyCoursesControllerProvider
    extends AutoDisposeFutureProvider<List<CoursePurchaseData>?> {
  /// See also [myCoursesController].
  MyCoursesControllerProvider({
    required String userToken,
  }) : this._internal(
          (ref) => myCoursesController(
            ref as MyCoursesControllerRef,
            userToken: userToken,
          ),
          from: myCoursesControllerProvider,
          name: r'myCoursesControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myCoursesControllerHash,
          dependencies: MyCoursesControllerFamily._dependencies,
          allTransitiveDependencies:
              MyCoursesControllerFamily._allTransitiveDependencies,
          userToken: userToken,
        );

  MyCoursesControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userToken,
  }) : super.internal();

  final String userToken;

  @override
  Override overrideWith(
    FutureOr<List<CoursePurchaseData>?> Function(
            MyCoursesControllerRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MyCoursesControllerProvider._internal(
        (ref) => create(ref as MyCoursesControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userToken: userToken,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CoursePurchaseData>?> createElement() {
    return _MyCoursesControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyCoursesControllerProvider && other.userToken == userToken;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userToken.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MyCoursesControllerRef
    on AutoDisposeFutureProviderRef<List<CoursePurchaseData>?> {
  /// The parameter `userToken` of this provider.
  String get userToken;
}

class _MyCoursesControllerProviderElement
    extends AutoDisposeFutureProviderElement<List<CoursePurchaseData>?>
    with MyCoursesControllerRef {
  _MyCoursesControllerProviderElement(super.provider);

  @override
  String get userToken => (origin as MyCoursesControllerProvider).userToken;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
