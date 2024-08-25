import 'dart:developer';

import 'package:course_app/common/models/course_enties.dart';
import 'package:course_app/common/models/lesson_entities.dart';
import 'package:course_app/pages/course_details/repo/course_detail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_controller.g.dart';

@riverpod
Future<CourseItem?> courseDetailController(CourseDetailControllerRef ref,
    {required int index}) async {
  CourseRequestEntity courseRequestEntity = CourseRequestEntity();
  courseRequestEntity.id = index;
  final reponse = await CourseRepo.courseDetail(params: courseRequestEntity);
  if (reponse.code == 200) {
    return reponse.data;
  } else {
    log("Request failed ${reponse.code} ${reponse.msg}");
  }

  return null;
}

@riverpod
Future<List<LessonItem>?> courseLessonListController(
    CourseLessonListControllerRef ref,
    {required int index}) async {
  LessonRequestEntity lessonRequestEntity = LessonRequestEntity();
  lessonRequestEntity.id = index;
  final response =
      await CourseRepo.courseLessonList(params: lessonRequestEntity);
  if (response.code == 200) {
    return response.data;
  } else {
    log("Request failed ${response.code} ${response.msg}");
  }

  return null;
}
