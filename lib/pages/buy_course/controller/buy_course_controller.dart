// import 'dart:developer';
//
// import 'package:course_app/common/models/course_enties.dart';
// import 'package:course_app/common/models/lesson_entities.dart';
// import 'package:course_app/pages/buy_course/repo/buy_course_repo.dart';
// import 'package:course_app/pages/course_details/repo/course_detail.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// part 'buy_course_controller.g.dart';
//
// @riverpod
// Future<String?> buyCourseController(BuyCourseControllerRef ref,
//     {required int index}) async {
//   CourseRequestEntity courseRequestEntity = CourseRequestEntity();
//   courseRequestEntity.id = index;
//   final response = await BuyCourseRepo.buyCourse(params: courseRequestEntity);
//   if (response.code == 200) {
//     return response.data;
//   } else {
//     log("Request failed ${response.code} ${response.msg}");
//   }
//
//   return null;
// }

import 'dart:developer';
import 'package:course_app/pages/buy_course/repo/buy_course_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/models/course_enties.dart';

part 'buy_course_controller.g.dart';

@riverpod
Future<Map<String, dynamic>?> buyCourseController(BuyCourseControllerRef ref,
    {required int index}) async {
  CourseRequestEntity courseRequestEntity = CourseRequestEntity();
  courseRequestEntity.id = index;

  // Make the request to your backend
  final response = await BuyCourseRepo.buyCourse(params: courseRequestEntity);

  if (response.code == 200) {
    // Assuming the response data contains the necessary Razorpay details
    return response.data as Map<String, dynamic>;
  } else {
    log("Request failed ${response.code} ${response.msg}");
  }

  return null;
}
