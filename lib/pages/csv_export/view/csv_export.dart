import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:course_app/global.dart';
import 'package:course_app/pages/csv_export/controller/csv_export_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';

import '../../../common/models/all_quiz_result.dart';

// Define a unique background task name
const String backgroundExportTaskName = 'automatedAnalyticsExportTask';

// Initialize WorkManager in your app's main.dart file
void initializeBackgroundTasks() {
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false, // Set to false in production
  );

  // Schedule the daily export task
  scheduleAnalyticsExport();
}

// The callback function that will be executed in the background
@pragma('vm:entry-point')
void callbackDispatcher() {
  Global.init();
  Workmanager().executeTask((taskName, inputData) async {
    try {
      await Global.init();
      if (taskName == backgroundExportTaskName) {
        log('Executing background analytics export task');

        // Get an instance of ProviderContainer for accessing providers
        final container = ProviderContainer();

        // Export and upload the analytics
        await AutomatedAnalyticsService.exportAndUploadAnalytics(container);

        // Dispose of the container after use
        container.dispose();

        log('Background analytics export task completed successfully');
      }
      return Future.value(true);
    } catch (e) {
      log('Error in background task: $e');
      return Future.value(false);
    }
  });
}

// Function to schedule export task to run every minute
void scheduleAnalyticsExport() {
  // Cancel any existing tasks with the same name
  Workmanager().cancelByUniqueName(backgroundExportTaskName);

  // Schedule a periodic task to run every 15 minutes (minimum allowed by WorkManager)
  Workmanager().registerPeriodicTask(
    backgroundExportTaskName,
    backgroundExportTaskName,
    frequency: const Duration(
        minutes: 1), // This is the minimum allowed by WorkManager
    existingWorkPolicy: ExistingWorkPolicy.replace,
    constraints: Constraints(
      networkType: NetworkType.connected, // Require internet connectivity
    ),
  );

  log('Scheduled analytics export to run every 15 minutes');
}

// Service class for automated analytics processing
class AutomatedAnalyticsService {
  // In the AutomatedAnalyticsService class
  static Future<void> exportAndUploadAnalytics(
      ProviderContainer container) async {
    try {
      log('Starting analytics export and upload process');
      final now = DateTime.now();
      final formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
      log('[Upload Started] Time: $formattedTime — Starting analytics export and upload process');

      // Check if there's any data to export
      final prefs = await SharedPreferences.getInstance();
      final analyticsKeys = prefs
          .getKeys()
          .where((key) => key.startsWith('video_analysis_data_'))
          .toList();

      log('Found ${analyticsKeys.length} analytics records to export');

      if (analyticsKeys.isEmpty) {
        log('No analytics data found to export');
        return;
      }

      // Generate CSV file
      log('Generating CSV file...');
      final filePath =
          await AnalyticsExportUtil.exportAnalyticsToCSV(container);
      log('Analytics exported to: $filePath');

      // Get the file ready to upload
      File csvFile = File(filePath);
      if (!await csvFile.exists()) {
        log('ERROR: CSV file was not created at path: $filePath');
        return;
      }

      final fileSize = await csvFile.length();
      log('CSV file size: ${fileSize} bytes');

      final userId = Global.storageService.getUserProfile().unique_id;
      log('Uploading for user ID: $userId');

      // Upload the file using the provider
      log('Starting upload to server...');
      final result = await container.read(csvUploadControllerProvider(
        csvFile: csvFile,
        userId: userId ?? "",
      ).future);

      if (result != null) {
        log('Analytics CSV file uploaded successfully. Server response: $result');
      } else {
        log('Failed to upload analytics file. Server returned null response.');
      }
    } catch (e, stackTrace) {
      log('Error in automated analytics export and upload: $e',
          error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}

// Utility class for exporting analytics - mostly unchanged
class AnalyticsExportUtil {
  static String formatTimestamp(String timestamp) {
    try {
      final DateTime dateTime = DateTime.parse(timestamp);
      return DateFormat('HH:mm:ss').format(dateTime);
    } catch (e) {
      log('Error formatting timestamp: $e');
      return '';
    }
  }

  static String formatDate(String input) {
    try {
      // More strict date parsing to prevent false positives
      if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(input) &&
          DateTime.tryParse(input) != null) {
        final DateTime dateTime = DateTime.parse(input);
        return DateFormat('dd-MMM').format(dateTime);
      }
      // If it's not a valid date, return the input as-is
      return input;
    } catch (e) {
      log('Error formatting date: $e');
      return input;
    }
  }

  static Future<String> exportAnalyticsToCSV(dynamic refOrReader) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final analyticsKeys = prefs
          .getKeys()
          .where((key) => key.startsWith('video_analysis_data_'))
          .toList();

      // CSV header
      List<String> csvRows = [
        'Unique ID,User ID,User Name,Course ID,Course Video ID,Session Date,Session Start Time,Session End Time,Session Total Watch Time,Total Pause Count,Pause Timestamps,Pause Durations,Video Progress,Quiz Unique Id,Quiz Score,TotalVideosInCourse',
      ];

      final uniqueId = Global.storageService.getUserProfile().unique_id;
      log("The unique ID is $uniqueId");
      final quizResult = await refOrReader.read(
        csvExportQuizResultControllerProvider(uniqueId: uniqueId ?? "").future,
      );

      for (String key in analyticsKeys) {
        log("This is the quiz result $quizResult");
        String? analyticsJson = prefs.getString(key);
        if (analyticsJson != null) {
          Map<String, dynamic> analytics = jsonDecode(analyticsJson);
          log("THIS IS ANALYTICS : $analytics");

          Map<String, dynamic> userProfile = analytics['userProfile'] ?? {};
          String userId = userProfile['id'] ?? '';
          String userName = userProfile['name'] ?? '';
          // Ensure full video ID is captured
          String videoId = analytics['videoId'] ?? '';
          String courseId = analytics['courseId'] ?? '';
          String courseVideoId = analytics['courseVideoId'] ?? '';
          int totalVideoInCourses = analytics['totalVideosInCourse'] ?? "";
          List<dynamic> watchSessions = analytics['watchSessions'] ?? [];

          for (var session in watchSessions) {
            List<dynamic> pauseEvents = session['pauseEvents'] ?? [];

            // Group all timestamps, durations, and progress values
            List<String> timestamps = [];
            List<String> durations = [];
            List<String> progressValues = [];

            for (var pauseEvent in pauseEvents) {
              timestamps.add(formatTimestamp(pauseEvent['timestamp']));
              durations.add(pauseEvent['duration']);
              progressValues
                  .add(pauseEvent['videoProgress'].toStringAsFixed(6));
            }

            String formatQuizIds(List<AllQuizResultData>? quizResults) {
              if (quizResults == null || quizResults.isEmpty) {
                return 'N/A';
              }
              return quizResults.map((quiz) => quiz.quiz_unique_id).join(';');
            }

            String formatQuizScores(List<AllQuizResultData>? quizResults) {
              if (quizResults == null || quizResults.isEmpty) {
                return 'N/A';
              }
              return quizResults.map((quiz) => quiz.score.toString()).join(';');
            }

            // Create the row with grouped values
            String row = [
              uniqueId,
              userId, // User ID
              userName,
              courseId,
              courseVideoId,

              // Use the full video ID here
              formatDate(session['date'] ?? ''),
              formatTimestamp(session['startTime'] ?? ''),
              formatTimestamp(session['endTime'] ?? ''),
              analytics['totalWatchTime'] ?? '00:00:00',
              analytics['pauseCount']?.toString() ?? '0',
              timestamps.join(';'),
              durations.join(';'),
              progressValues.join(';'),
              formatQuizIds(quizResult),
              formatQuizScores(quizResult),
              totalVideoInCourses.toString(),
            ].join(',');

            csvRows.add(row);
          }
        }
      }

      // Get the Downloads directory
      final directory = Directory('/storage/emulated/0/Download');
      if (!directory.existsSync()) {
        throw Exception('Downloads directory not found!');
      }

      final fileName =
          'video_analytics_${DateTime.now().millisecondsSinceEpoch}.csv';
      final filePath = path.join(directory.path, fileName);

      // Write the CSV file to the Downloads directory
      File csvFile = File(filePath);
      await csvFile.writeAsString(csvRows.join('\n'));

      log('CSV file exported successfully to: $filePath');
      return filePath;
    } catch (e) {
      log('Error exporting analytics to CSV: $e');
      rethrow;
    }
  }
}

// This class is now simplified - just contains the actual analytics functionality
// without any UI elements
class BackgroundAnalyticsService {
  // Method to manually trigger the export and upload (if needed for testing)
  static Future<void> manualExportAndUpload(ProviderContainer container) async {
    await AutomatedAnalyticsService.exportAndUploadAnalytics(container);
  }

  // Method to check if the background task is scheduled
  static Future<bool> isTaskScheduled() async {
    // This is a simplified check. WorkManager doesn't provide direct API for this
    // So we use SharedPreferences to track our own scheduling state
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('analytics_task_scheduled') ?? false;
  }

  // Method to manually schedule the task (if needed)
  static void scheduleTask() {
    scheduleAnalyticsExport();
    // Track that we've scheduled the task
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('analytics_task_scheduled', true);
    });
  }
}
