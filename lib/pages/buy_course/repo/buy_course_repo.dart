import '../../../common/models/base_entitiese.dart';
import '../../../common/models/course_enties.dart';
import '../../../common/utils/http_util.dart';

class BuyCourseRepo {
  static Future<BaseResponseEntity> buyCourse(
      {CourseRequestEntity? params}) async {
    var response = await HttpUtil().post(
      "api/checkout",
      queryParameters: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response as Map<String, dynamic>);
  }
}
