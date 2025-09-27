import 'dart:developer';

import 'package:course_app/common/models/QuizResultResponseEntity.dart';
import 'package:course_app/common/models/QuizSubmitRequestEntity.dart';
import 'package:course_app/common/models/QuizSubmitResponseEntity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/models/quiz_start_request.dart';
import '../../../common/models/quiz_start_response.dart';
import '../repo/quiz_repo.dart';

part 'quiz_controller.g.dart';

@riverpod
Future<QuizStartItem?> startQuizController(
  StartQuizControllerRef ref, {
  required QuizStartRequestEntity params,
}) async {
  try {
    final response = await QuizRepo.startQuiz(params: params);
    log("Response for: $response");

    // ADD DEBUG LOGGING FOR RESPONSE DATA
    if (response.data != null) {
      log("Response data type: ${response.data.runtimeType}");
      log("Response data: ${response.data}");
      if (response.data!.quiz != null) {
        log("Quiz data: ${response.data!.quiz}");
        log("Quiz user_id type: ${response.data!.quiz!.userId.runtimeType}");
        log("Quiz user_id value: ${response.data!.quiz!.userId}");
        log("Quiz course_id type: ${response.data!.quiz!.courseId.runtimeType}");
        log("Quiz course_id value: ${response.data!.quiz!.courseId}");
        log("Quiz lesson_id type: ${response.data!.quiz!.lessonId.runtimeType}");
        log("Quiz lesson_id value: ${response.data!.quiz!.lessonId}");
      }
    }

    if (response.code == 200) {
      return response.data;
    } else if (response.code == 201) {
      return response.data;
    } else {
      log("Request failed ${response.code} ${response.msg}");
    }
  } catch (e) {
    log("Error occurred while starting quiz: $e");
    log("Error type: ${e.runtimeType}");
    if (e.toString().contains("String") && e.toString().contains("int")) {
      log("TYPE CONVERSION ERROR DETECTED");
      log("This suggests one of the fields is a string when it should be an integer");
    }
  }
  return null;
}

@riverpod
Future<QuizSubmitItem?> submitQuizController(
  SubmitQuizControllerRef ref, {
  required QuizSubmitRequestEntity params,
}) async {
  try {
    final response = await QuizRepo.submitQuiz(params: params);
    if (response.code == 200) {
      return response.data;
    } else {
      log("Request failed ${response.code} ${response.msg}");
    }
  } catch (e) {
    log("Error occurred while submitting quiz: $e");
  }
  return null;
}

@riverpod
Future<QuizResultItem?> getQuizResultController(
  GetQuizResultControllerRef ref, {
  required String uniqueId,
}) async {
  try {
    final response = await QuizRepo.getResult(quizUniqueId: uniqueId);
    if (response.code == 200) {
      return response.data;
    } else {
      log("Request failed ${response.code} ${response.msg}");
    }
  } catch (e) {
    log("Error occurred while getting quiz result: $e");
  }
  return null;
}
