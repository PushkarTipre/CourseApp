import 'dart:convert';
import 'dart:developer';

import 'package:course_app/common/models/UserRequestEntity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../common/models/user.dart';
import '../../../../common/utils/constants.dart';
import '../../../../global.dart';
import '../repo/edit_profile_repo.dart';

part 'edit_profile_controller.g.dart';

@riverpod
Future<bool> editProfileController(EditProfileControllerRef ref,
    {required UserRequestEntity editProfile}) async {
  try {
    final response = await EditProfileRepo.updateUserProfile(editProfile);
    if (response.code == 200 && response.data != null) {
      Global.storageService.setString(
          AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(response.data));
      return true;
    } else {
      log("Update failed: ${response.code} ${response.msg}");
      return false;
    }
  } catch (e) {
    log("Error updating profile: $e");
    return false;
  }
}

@riverpod
class ProfileInfo extends _$ProfileInfo {
  @override
  UserProfile build() => Global.storageService.getUserProfile();
}
