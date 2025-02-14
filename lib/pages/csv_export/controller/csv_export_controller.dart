import 'dart:developer';

import 'package:course_app/common/models/QuizResultResponseEntity.dart';
import 'package:course_app/common/models/all_quiz_result.dart';
import 'package:course_app/pages/csv_export/repo/csv_repo.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'csv_export_controller.g.dart';

@riverpod
Future<List<AllQuizResultData>?> csvExportQuizResultController(
  CsvExportQuizResultControllerRef ref, {
  required String uniqueId,
}) async {
  try {
    final response = await CsvRepo.getAllResult(uniqueId: uniqueId);
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
