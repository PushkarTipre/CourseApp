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
    if (response.code == 200) {
      return response.data;
    } else if (response.code == 201) {
      return response.data;
    } else {
      log("Request failed ${response.code} ${response.msg}");
    }
  } catch (e) {
    log("Error occurred while starting quiz: $e");
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
