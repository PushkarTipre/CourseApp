import 'dart:io';

import 'package:dio/dio.dart';

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

  // Method for uploading a single file (for backward compatibility)
  static Future<Map<String, dynamic>> uploadCsvFile({
    required File csvFile,
    required String userId,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      // Create FormData for multipart request
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          csvFile.path,
          filename: csvFile.path.split('/').last,
        ),
        'user_id': userId,
      });

      // Add any additional data if provided
      if (additionalData != null) {
        additionalData.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      var response = await HttpUtil().post(
        "api/uploadAndProcessCsvFile", // Use the single file endpoint
        data: formData,
      );

      return response;
    } catch (e) {
      throw Exception(
          'Error occurred while uploading CSV file: ${e.toString()}');
    }
  }

  // New method for uploading multiple files
  static Future<Map<String, dynamic>> uploadMultipleCsvFiles({
    required List<File> csvFiles,
    required List<String> userIds,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      // Validate that the number of files and user IDs match
      if (csvFiles.length != userIds.length) {
        throw Exception('Number of files and user IDs must match');
      }

      // Create FormData for multipart request
      FormData formData = FormData();

      // Add each file to the request
      for (int i = 0; i < csvFiles.length; i++) {
        formData.files.add(
          MapEntry(
            'files[]',
            await MultipartFile.fromFile(
              csvFiles[i].path,
              filename: csvFiles[i].path.split('/').last,
            ),
          ),
        );
      }

      for (int i = 0; i < userIds.length; i++) {
        formData.fields.add(MapEntry('user_ids[]', userIds[i]));
      }

      // Add any additional data if provided
      if (additionalData != null) {
        additionalData.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      var response = await HttpUtil().post(
        "api/uploadAndProcessCsvFiles",
        data: formData,
      );

      return response;
    } catch (e) {
      throw Exception(
          'Error occurred while uploading CSV files: ${e.toString()}');
    }
  }
}
