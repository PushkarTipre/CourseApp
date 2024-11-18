// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$editProfileControllerHash() =>
    r'11fdc981379da68fe7f060abb3db437b135d379f';

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

/// See also [editProfileController].
@ProviderFor(editProfileController)
const editProfileControllerProvider = EditProfileControllerFamily();

/// See also [editProfileController].
class EditProfileControllerFamily extends Family<AsyncValue<bool>> {
  /// See also [editProfileController].
  const EditProfileControllerFamily();

  /// See also [editProfileController].
  EditProfileControllerProvider call({
    required UserRequestEntity editProfile,
  }) {
    return EditProfileControllerProvider(
      editProfile: editProfile,
    );
  }

  @override
  EditProfileControllerProvider getProviderOverride(
    covariant EditProfileControllerProvider provider,
  ) {
    return call(
      editProfile: provider.editProfile,
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
  String? get name => r'editProfileControllerProvider';
}

/// See also [editProfileController].
class EditProfileControllerProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [editProfileController].
  EditProfileControllerProvider({
    required UserRequestEntity editProfile,
  }) : this._internal(
          (ref) => editProfileController(
            ref as EditProfileControllerRef,
            editProfile: editProfile,
          ),
          from: editProfileControllerProvider,
          name: r'editProfileControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editProfileControllerHash,
          dependencies: EditProfileControllerFamily._dependencies,
          allTransitiveDependencies:
              EditProfileControllerFamily._allTransitiveDependencies,
          editProfile: editProfile,
        );

  EditProfileControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.editProfile,
  }) : super.internal();

  final UserRequestEntity editProfile;

  @override
  Override overrideWith(
    FutureOr<bool> Function(EditProfileControllerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EditProfileControllerProvider._internal(
        (ref) => create(ref as EditProfileControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        editProfile: editProfile,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _EditProfileControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditProfileControllerProvider &&
        other.editProfile == editProfile;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, editProfile.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EditProfileControllerRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `editProfile` of this provider.
  UserRequestEntity get editProfile;
}

class _EditProfileControllerProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with EditProfileControllerRef {
  _EditProfileControllerProviderElement(super.provider);

  @override
  UserRequestEntity get editProfile =>
      (origin as EditProfileControllerProvider).editProfile;
}

String _$profileInfoHash() => r'1bd1de8cd49288b23652ab2833c8d956a2df5930';

/// See also [ProfileInfo].
@ProviderFor(ProfileInfo)
final profileInfoProvider =
    AutoDisposeNotifierProvider<ProfileInfo, UserProfile>.internal(
  ProfileInfo.new,
  name: r'profileInfoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$profileInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProfileInfo = AutoDisposeNotifier<UserProfile>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
