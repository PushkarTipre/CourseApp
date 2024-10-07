import '../../../common/models/course_enties.dart';
import '../../../common/utils/http_util.dart';

class CoursesSearchRepo {
  static Future<CourseListResponseEntity> coursesDefaultSearch(
      {CourseRequestEntity? params}) async {
    var response = await HttpUtil().post(
      "api/coursesSearchDefault",
    );
    return CourseListResponseEntity.fromJson(response as Map<String, dynamic>);
  }

  static Future<CourseListResponseEntity> coursesSearch(
      {SearchRequestEntity? params}) async {
    var response = await HttpUtil().post(
      "api/coursesSearch",
      queryParameters: params?.toJson(),
    );
    return CourseListResponseEntity.fromJson(response as Map<String, dynamic>);
  }
}
