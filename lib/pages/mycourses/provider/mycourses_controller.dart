import 'dart:developer';

import 'package:course_app/pages/home/repo/HomeRepo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/models/CoursePurchasedInfo.dart';

part 'mycourses_controller.g.dart';

@riverpod
Future<List<CoursePurchaseData>?> myCoursesController(
  MyCoursesControllerRef ref, {
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
