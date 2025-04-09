import 'dart:developer';

import 'package:course_app/common/models/course_enties.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/models/category_entity.dart';
import '../repo/category_course_repo.dart';

part 'category_course_controller.g.dart';

@riverpod
Future<List<CourseItem>?> categoryCourseController(
  CategoryCourseControllerRef ref, {
  int? categoryId,
}) async {
  try {
    final response =
        await CategoryCourseRepo.getCourseList(categoryId: categoryId);
    log("Response is here please check: $response");
    if (response.code == 200) {
      log("Mapped Data: ${response.data}");
      return response.data;
    } else {
      log("Request failed: ${response.code} - ${response.msg}");
    }
  } catch (e) {
    log("Error occurred while fetching course list: $e");
  }
  return null;
}

@riverpod
Future<List<CourseCategory>?> courseCategoryController(
  CourseCategoryControllerRef ref,
) async {
  try {
    final response = await CategoryCourseRepo.getCourseCategoryList();
    log("Course Category Response: $response");

    if (response.code == 200) {
      return response.data;
    } else {
      log("Course Category Request failed: ${response.code} - ${response.msg}");
    }
  } catch (e) {
    log("Error occurred while fetching course category list: $e");
  }
  return null;
}
