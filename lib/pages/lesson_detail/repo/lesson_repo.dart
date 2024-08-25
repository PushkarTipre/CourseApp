import '../../../common/models/lesson_entities.dart';
import '../../../common/utils/http_util.dart';

class LessonRepo {
  static Future<LessonDetailResponseEntity> courseLessonDetail(
      {LessonRequestEntity? params}) async {
    var response = await HttpUtil()
        .post("api/lessonDetail", queryParameters: params?.toJson());
    return LessonDetailResponseEntity.fromJson(response);
  }
}
