import '../../../../common/models/course_enties.dart';
import '../../../../common/utils/http_util.dart';

class CoursesBoughtRepo {
  static Future<CourseListResponseEntity> coursesBought() async {
    var response = await HttpUtil().post("api/coursesBought");
    return CourseListResponseEntity.fromJson(response);
  }
}
