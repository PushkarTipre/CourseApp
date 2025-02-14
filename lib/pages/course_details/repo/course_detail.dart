import 'dart:developer';

import 'package:course_app/common/models/course_enties.dart';
import 'package:course_app/common/models/lesson_entities.dart';
import 'package:course_app/common/utils/http_util.dart';

import '../../../common/models/CheckVideoAccessResponseEntity.dart';

class CourseRepo {
  static Future<CourseDetailResponseEntity> courseDetail(
      {CourseRequestEntity? params}) async {
    var response = await HttpUtil().post(
      "api/courseDetail",
      queryParameters: params?.toJson(),
    );
    return CourseDetailResponseEntity.fromJson(response);
  }

  static Future<LessonListResponseEntity> courseLessonList(
      {LessonRequestEntity? params}) async {
    var response = await HttpUtil()
        .post("api/lessonList", queryParameters: params?.toJson());
    return LessonListResponseEntity.fromJson(response);
  }

  static Future<CheckVideoAccessResponseEntity> checkVideoAccess(
      {required int courseId}) async {
    try {
      var response = await HttpUtil().post(
        "api/checkVideoAccess",
        queryParameters: {'course_id': courseId.toString()},
      );

      log('Response data please check: $response');

      return CheckVideoAccessResponseEntity.fromJson(response);
    } catch (e) {
      log('Error Response please check: $e'); // Log the error in case of failure (e.g., 403)
      return CheckVideoAccessResponseEntity(
        code: 403,
        msg: 'Access Denied',
        hasAccess: false,
      );
    }
  }

  static Future<CheckVideoAccessResponseEntity> enrollInCourse(
      {required int courseId}) async {
    try {
      var response = await HttpUtil().post(
        "api/enrollInCourse",
        queryParameters: {'course_id': courseId.toString()},
      );

      log('Response data please check: $response');

      return CheckVideoAccessResponseEntity.fromJson(response);
    } catch (e) {
      log('Error Response please check: $e');
      return CheckVideoAccessResponseEntity(
        code: 403,
        msg: 'Access Denied',
        hasAccess: false,
      );
    }
  }
}
