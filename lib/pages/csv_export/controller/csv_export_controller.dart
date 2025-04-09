import 'dart:developer';
import 'dart:io';

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

@riverpod
Future<Map<String, dynamic>?> csvUploadController(
  CsvUploadControllerRef ref, {
  required File csvFile,
  required String userId,
  Map<String, dynamic>? additionalData,
}) async {
  try {
    final response = await CsvRepo.uploadCsvFile(
      csvFile: csvFile,
      userId: userId,
      additionalData: additionalData,
    );
    return response;
  } catch (e) {
    log("Error occurred while uploading CSV file: $e");
  }
  return null;
}
