// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$purchasedCoursesControllerHash() =>
    r'c84a81819d1e3ac31ded378aed4b116a16d1eb0e';

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

/// See also [purchasedCoursesController].
@ProviderFor(purchasedCoursesController)
const purchasedCoursesControllerProvider = PurchasedCoursesControllerFamily();

/// See also [purchasedCoursesController].
class PurchasedCoursesControllerFamily
    extends Family<AsyncValue<List<CoursePurchaseData>?>> {
  /// See also [purchasedCoursesController].
  const PurchasedCoursesControllerFamily();

  /// See also [purchasedCoursesController].
  PurchasedCoursesControllerProvider call({
    required String userToken,
  }) {
    return PurchasedCoursesControllerProvider(
      userToken: userToken,
    );
  }

  @override
  PurchasedCoursesControllerProvider getProviderOverride(
    covariant PurchasedCoursesControllerProvider provider,
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
  String? get name => r'purchasedCoursesControllerProvider';
}

/// See also [purchasedCoursesController].
class PurchasedCoursesControllerProvider
    extends AutoDisposeFutureProvider<List<CoursePurchaseData>?> {
  /// See also [purchasedCoursesController].
  PurchasedCoursesControllerProvider({
    required String userToken,
  }) : this._internal(
          (ref) => purchasedCoursesController(
            ref as PurchasedCoursesControllerRef,
            userToken: userToken,
          ),
          from: purchasedCoursesControllerProvider,
          name: r'purchasedCoursesControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$purchasedCoursesControllerHash,
          dependencies: PurchasedCoursesControllerFamily._dependencies,
          allTransitiveDependencies:
              PurchasedCoursesControllerFamily._allTransitiveDependencies,
          userToken: userToken,
        );

  PurchasedCoursesControllerProvider._internal(
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
            PurchasedCoursesControllerRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PurchasedCoursesControllerProvider._internal(
        (ref) => create(ref as PurchasedCoursesControllerRef),
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
    return _PurchasedCoursesControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PurchasedCoursesControllerProvider &&
        other.userToken == userToken;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userToken.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PurchasedCoursesControllerRef
    on AutoDisposeFutureProviderRef<List<CoursePurchaseData>?> {
  /// The parameter `userToken` of this provider.
  String get userToken;
}

class _PurchasedCoursesControllerProviderElement
    extends AutoDisposeFutureProviderElement<List<CoursePurchaseData>?>
    with PurchasedCoursesControllerRef {
  _PurchasedCoursesControllerProviderElement(super.provider);

  @override
  String get userToken =>
      (origin as PurchasedCoursesControllerProvider).userToken;
}

String _$homeScreenBannerIndexHash() =>
    r'd4eae71e984f66d01bba2ddaabd1c35a5970166f';

/// See also [HomeScreenBannerIndex].
@ProviderFor(HomeScreenBannerIndex)
final homeScreenBannerIndexProvider =
    NotifierProvider<HomeScreenBannerIndex, int>.internal(
  HomeScreenBannerIndex.new,
  name: r'homeScreenBannerIndexProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeScreenBannerIndexHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeScreenBannerIndex = Notifier<int>;
String _$homeUserProfileHash() => r'269c94735a9c7c7a4fbd45c32e752b86da25547b';

/// See also [HomeUserProfile].
@ProviderFor(HomeUserProfile)
final homeUserProfileProvider =
    AutoDisposeAsyncNotifierProvider<HomeUserProfile, UserProfile>.internal(
  HomeUserProfile.new,
  name: r'homeUserProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeUserProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeUserProfile = AutoDisposeAsyncNotifier<UserProfile>;
String _$homeCourseListHash() => r'26c1cc848e76d9688be1994a1f463faf6d0f3981';

/// See also [HomeCourseList].
@ProviderFor(HomeCourseList)
final homeCourseListProvider =
    AsyncNotifierProvider<HomeCourseList, List<CourseItem>?>.internal(
  HomeCourseList.new,
  name: r'homeCourseListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeCourseListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeCourseList = AsyncNotifier<List<CourseItem>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
