import 'dart:developer';

import 'package:course_app/common/models/QuizSubmitRequestEntity.dart';

import '../../../common/models/QuizResultResponseEntity.dart';
import '../../../common/models/QuizSubmitResponseEntity.dart';
import '../../../common/models/quiz_start_request.dart';
import '../../../common/models/quiz_start_response.dart';
import '../../../common/utils/http_util.dart';

class QuizRepo {
  // Start Quiz
  static Future<QuizStartResponseEntity> startQuiz({
    required QuizStartRequestEntity params,
  }) async {
    try {
      var response = await HttpUtil().post(
        "api/startQuiz",
        queryParameters: params.toJson(),
      );
      log("Response for: $response");
      return QuizStartResponseEntity.fromJson(response);
    } catch (e, stackTrace) {
      log("Error occurred while starting quiz: $e");
      log("Stack trace: $stackTrace");
      throw Exception('Error occurred while starting quiz');
    }
  }

  // Submit Quiz
  static Future<QuizSubmitResponseEntity> submitQuiz({
    required QuizSubmitRequestEntity params,
  }) async {
    try {
      var response = await HttpUtil().post(
        "api/submitQuiz",
        queryParameters: params.toJson(),
      );
      return QuizSubmitResponseEntity.fromJson(response);
    } catch (e, stackTrace) {
      log("Error occurred while starting quiz: $e");
      log("Stack trace: $stackTrace");
      throw Exception('Error occurred while submitting quiz');
    }
  }

  // Get Quiz Result
  static Future<QuizResultResponseEntity> getResult({
    required String quizUniqueId,
  }) async {
    try {
      var response = await HttpUtil().get(
        "api/getQuizResult",
        queryParameters: {
          'quiz_unique_id': quizUniqueId,
        },
      );
      return QuizResultResponseEntity.fromJson(response);
    } catch (e) {
      throw Exception('Error occurred while fetching quiz result');
    }
  }
}
