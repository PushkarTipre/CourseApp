// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
