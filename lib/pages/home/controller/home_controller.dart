import 'dart:developer';

import 'package:course_app/common/api/course_api.dart';
import 'package:course_app/common/models/course_enties.dart';
import 'package:course_app/common/models/entities.dart';
import 'package:course_app/pages/home/repo/HomeRepo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/models/CoursePurchasedInfo.dart';
import '../../../global.dart';
import '../../course_details/repo/course_detail.dart';
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

@Riverpod(keepAlive: true)
class HomeCourseList extends _$HomeCourseList {
  Future<List<CourseItem>?> fetchCourseList() async {
    var result = await CourseAPI.courseList();
    if (result.code == 200) {
      return result.data;
    }
    return null;
  }

  @override
  FutureOr<List<CourseItem>?> build() async {
    return fetchCourseList();
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
    if (response.code == 200 && response.status == true) {
      log("Mapped Data: ${response.data}");
      return response.data; // Returns List<CoursePurchaseData>
    } else {
      log("Request failed ${response.code} ${response.status}");
    }
  } catch (e) {
    log("Error occurred while fetching purchased courses: $e");
  }
  return null;
}
