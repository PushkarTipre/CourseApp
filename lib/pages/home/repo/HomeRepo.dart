import '../../../common/models/CoursePurchasedInfo.dart';
import '../../../common/utils/http_util.dart';

class HomeRepo {
  static Future<CoursePurchaseResponseEntity> getPurchasedCourseInfo({
    required String user_token,
  }) async {
    // try {
    var response = await HttpUtil().get(
      "api/latestCourses",
      queryParameters: {
        'user_token': user_token,
      },
    );
    return CoursePurchaseResponseEntity.fromJson(response);
    // } catch (e) {
    //   throw Exception('Error occurred while fetching quiz result');
    // }
  }
}
