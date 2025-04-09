import '../models/course_enties.dart';
import '../utils/http_util.dart';

class CourseAPI {
  static Future<CourseListResponseEntity> courseList() async {
    var response = await HttpUtil().post("api/courseList");
    return CourseListResponseEntity.fromJson(response);
  }

  static Future<CourseListResponseEntity> popularCourses() async {
    var response = await HttpUtil().post("api/popularCourses");
    return CourseListResponseEntity.fromJson(response);
  }

  static Future<CourseListResponseEntity> newestCourses() async {
    var response = await HttpUtil().post("api/newestCourses");
    return CourseListResponseEntity.fromJson(response);
  }
}
