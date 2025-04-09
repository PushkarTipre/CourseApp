import 'dart:developer';

import 'package:course_app/common/api/course_api.dart';
import 'package:course_app/common/models/course_enties.dart';
import 'package:course_app/common/models/entities.dart';
import 'package:course_app/pages/home/repo/HomeRepo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/models/CoursePurchasedInfo.dart';
import '../../../global.dart';

part 'home_controller.g.dart';

@Riverpod(keepAlive: true)
class HomeScreenBannerIndex extends _$HomeScreenBannerIndex {
  @override
  int build() => 0;

  void setIndex(int index) {
    state = index;
  }
}

@riverpod
class HomeUserProfile extends _$HomeUserProfile {
  @override
  FutureOr<UserProfile> build() {
    return Global.storageService.getUserProfile();
  }
}

@riverpod
class PopularCourses extends _$PopularCourses {
  Future<List<CourseItem>?> fetchPopularCourseList() async {
    var result = await CourseAPI.popularCourses();
    if (result.code == 200) {
      return result.data;
    }
    return null;
  }

  @override
  FutureOr<List<CourseItem>?> build() async {
    return fetchPopularCourseList();
  }
}

@riverpod
class NewestCourses extends _$NewestCourses {
  Future<List<CourseItem>?> fetchNewCoursesList() async {
    var result = await CourseAPI.newestCourses();
    if (result.code == 200) {
      return result.data;
    }
    return null;
  }

  @override
  FutureOr<List<CourseItem>?> build() async {
    return fetchNewCoursesList();
  }
}

@riverpod
Future<List<CoursePurchaseData>?> purchasedCoursesController(
  PurchasedCoursesControllerRef ref, {
  required String userToken,
}) async {
  try {
    final response =
        await HomeRepo.getPurchasedCourseInfo(user_token: userToken);
    log("Response is here please check: $response");
    if (response.code == 200 && response.status == true) {
      log("Mapped Data: ${response.data}");
      return response.data;
    } else {
      log("Request failed ${response.code} ${response.status}");
    }
  } catch (e) {
    log("Error occurred while fetching purchased courses: $e");
  }
  return null;
}
