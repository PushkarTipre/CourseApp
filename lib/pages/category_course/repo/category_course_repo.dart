import 'dart:developer';

import '../../../common/models/category_entity.dart';
import '../../../common/models/course_enties.dart';
import '../../../common/utils/http_util.dart';

class CategoryCourseRepo {
  static Future<CourseListResponseEntity> getCourseList(
      {int? categoryId}) async {
    try {
      var response = await HttpUtil().post(
        "api/courseListWithFilter",
        queryParameters: categoryId != null
            ? {
                'category': categoryId.toString(),
              }
            : null,
      );

      return CourseListResponseEntity.fromJson(response);
    } catch (e) {
      throw Exception('Error occurred while fetching the course list.');
    }
  }

  static Future<CourseCategoryResponseEntity> getCourseCategoryList() async {
    try {
      var response = await HttpUtil().get("api/courseCategories");

      return CourseCategoryResponseEntity.fromJson(response);
    } catch (e) {
      throw Exception(
          'Error occurred while fetching the course category list.');
    }
  }
}
