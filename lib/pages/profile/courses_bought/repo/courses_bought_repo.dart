import 'package:course_app/common/models/course_enties.dart';

import '../../../../common/utils/http_util.dart';

class CoursesBoughtRepo {
  static Future<CourseListResponseEntity> coursesBought(
      {CourseRequestEntity? params}) async {
    var response = await HttpUtil().post(
      "api/coursesBought",
    );
    return CourseListResponseEntity.fromJson(response as Map<String, dynamic>);
  }
}
