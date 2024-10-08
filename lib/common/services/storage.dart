// // ignore_for_file: unused_import
//
// import 'dart:convert';
//
// import 'package:course_app/common/models/entities.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../utils/constants.dart';
//
// class StorageService {
//   late final SharedPreferences _pref;
//
//   Future<StorageService> init() async {
//     _pref = await SharedPreferences.getInstance();
//     return this;
//   }
//
//   Future<bool> setString(String key, String value) async {
//     return await _pref.setString(key, value);
//   }
//
//   String getString(String key) {
//     return _pref.getString(key) ?? "";
//   }
//
//   String getUserToken() {
//     return _pref.getString(AppConstants.STORAGE_USER_TOKEN_KEY) ?? "";
//   }
//
//   Future<bool> setBool(String key, bool value) async {
//     return await _pref.setBool(key, value);
//   }
//
//   bool getDeviceFirstOpen() {
//     return _pref.getBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_KEY) ?? false;
//   }
//
//   bool isLoggedIn() {
//     return _pref.getString(AppConstants.STORAGE_USER_PROFILE_KEY) != null
//         ? true
//         : false;
//   }
//
//   UserProfile getUserProfile() {
//     var profile = _pref.getString(AppConstants.STORAGE_USER_PROFILE_KEY) ?? "";
//     var profileJson = jsonDecode(profile);
//     var userProfile = UserProfile.fromJson(profileJson);
//     return userProfile;
//   }
//
//   Future<bool> remove(String key) async {
//     return await _pref.remove(key);
//   }
// }

import 'dart:convert';
import 'package:course_app/common/models/entities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class StorageService {
  late final SharedPreferences _pref;

  Future<StorageService> init() async {
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(String key, String value) async {
    return await _pref.setString(key, value);
  }

  String getString(String key) {
    return _pref.getString(key) ?? "";
  }

  String getUserToken() {
    return _pref.getString(AppConstants.STORAGE_USER_TOKEN_KEY) ?? "";
  }

  Future<bool> setBool(String key, bool value) async {
    return await _pref.setBool(key, value);
  }

  bool getDeviceFirstOpen() {
    return _pref.getBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_KEY) ?? false;
  }

  bool isLoggedIn() {
    return _pref.getString(AppConstants.STORAGE_USER_PROFILE_KEY) != null;
  }

  UserProfile getUserProfile() {
    var profile = _pref.getString(AppConstants.STORAGE_USER_PROFILE_KEY) ?? "";
    if (profile.isEmpty) {
      return UserProfile(); // Return a default UserProfile if no profile is stored
    }
    var profileJson = jsonDecode(profile);
    return UserProfile.fromJson(profileJson);
  }

  Future<bool> remove(String key) async {
    return await _pref.remove(key);
  }
}
