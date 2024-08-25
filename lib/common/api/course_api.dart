import '../models/course_enties.dart';
import '../utils/http_util.dart';

class CourseAPI {
  static Future<CourseListResponseEntity> courseList() async {
    var response = await HttpUtil().post("api/courseList");
    return CourseListResponseEntity.fromJson(response);
  }
}
