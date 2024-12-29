import '../../../../common/models/QuizResultResponseEntity.dart';

import '../../../../common/utils/http_util.dart';
import '../../../common/models/all_quiz_result.dart';

class CsvRepo {
  static Future<AllQuizResultResponseEntity> getAllResult({
    required String uniqueId,
  }) async {
    try {
      var response = await HttpUtil().post(
        "api/getAllQuizResults",
        queryParameters: {
          'unique_id': uniqueId,
        },
      );
      return AllQuizResultResponseEntity.fromJson(response);
    } catch (e) {
      throw Exception('Error occurred while fetching quiz result');
    }
  }
}
