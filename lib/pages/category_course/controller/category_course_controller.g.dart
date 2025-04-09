// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_course_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoryCourseControllerHash() =>
    r'f596dc55d62193c13565a43574924bd26d622415';

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

/// See also [categoryCourseController].
@ProviderFor(categoryCourseController)
const categoryCourseControllerProvider = CategoryCourseControllerFamily();

/// See also [categoryCourseController].
class CategoryCourseControllerFamily
    extends Family<AsyncValue<List<CourseItem>?>> {
  /// See also [categoryCourseController].
  const CategoryCourseControllerFamily();

  /// See also [categoryCourseController].
  CategoryCourseControllerProvider call({
    int? categoryId,
  }) {
    return CategoryCourseControllerProvider(
      categoryId: categoryId,
    );
  }

  @override
  CategoryCourseControllerProvider getProviderOverride(
    covariant CategoryCourseControllerProvider provider,
  ) {
    return call(
      categoryId: provider.categoryId,
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
  String? get name => r'categoryCourseControllerProvider';
}

/// See also [categoryCourseController].
class CategoryCourseControllerProvider
    extends AutoDisposeFutureProvider<List<CourseItem>?> {
  /// See also [categoryCourseController].
  CategoryCourseControllerProvider({
    int? categoryId,
  }) : this._internal(
          (ref) => categoryCourseController(
            ref as CategoryCourseControllerRef,
            categoryId: categoryId,
          ),
          from: categoryCourseControllerProvider,
          name: r'categoryCourseControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$categoryCourseControllerHash,
          dependencies: CategoryCourseControllerFamily._dependencies,
          allTransitiveDependencies:
              CategoryCourseControllerFamily._allTransitiveDependencies,
          categoryId: categoryId,
        );

  CategoryCourseControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int? categoryId;

  @override
  Override overrideWith(
    FutureOr<List<CourseItem>?> Function(CategoryCourseControllerRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CategoryCourseControllerProvider._internal(
        (ref) => create(ref as CategoryCourseControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CourseItem>?> createElement() {
    return _CategoryCourseControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryCourseControllerProvider &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CategoryCourseControllerRef
    on AutoDisposeFutureProviderRef<List<CourseItem>?> {
  /// The parameter `categoryId` of this provider.
  int? get categoryId;
}

class _CategoryCourseControllerProviderElement
    extends AutoDisposeFutureProviderElement<List<CourseItem>?>
    with CategoryCourseControllerRef {
  _CategoryCourseControllerProviderElement(super.provider);

  @override
  int? get categoryId =>
      (origin as CategoryCourseControllerProvider).categoryId;
}

String _$courseCategoryControllerHash() =>
    r'65d78c71225481f274b8465c96feab4f78bce6cd';

/// See also [courseCategoryController].
@ProviderFor(courseCategoryController)
final courseCategoryControllerProvider =
    AutoDisposeFutureProvider<List<CourseCategory>?>.internal(
  courseCategoryController,
  name: r'courseCategoryControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$courseCategoryControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CourseCategoryControllerRef
    = AutoDisposeFutureProviderRef<List<CourseCategory>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
