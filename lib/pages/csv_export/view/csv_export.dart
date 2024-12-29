import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:course_app/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';

import '../../../common/models/all_quiz_result.dart';
import '../controller/csv_export_controller.dart';

// Main screen widget
class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Analytics'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => AnalyticsExportHandler.exportAnalytics(context, ref),
          child: const Text('Export Analytics'),
        ),
      ),
    );
  }
}

// Utility class for exporting analytics
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

  static Future<String> exportAnalyticsToCSV(WidgetRef ref) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final analyticsKeys = prefs
          .getKeys()
          .where((key) => key.startsWith('video_analysis_data_'))
          .toList();

      // CSV header
      List<String> csvRows = [
        'Unique ID,User ID,User Name,Course ID,Course Video ID,Session Date,Session Start Time,Session End Time,Session Total Watch Time,Total Pause Count,Pause Timestamps,Pause Durations,Video Progress,Quiz Unique Id,Quiz Score,',
      ];

      final uniqueId = Global.storageService.getUserProfile().unique_id;
      log("The unique ID is $uniqueId");
      final quizResult = await ref.read(
        csvExportQuizResultControllerProvider(uniqueId: "6766fa42531ad").future,
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
              videoId,
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

// Handler class for export operations
class AnalyticsExportHandler {
  static Future<void> exportAnalytics(
      BuildContext context, WidgetRef ref) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Generate CSV file
      String filePath = await AnalyticsExportUtil.exportAnalyticsToCSV(ref);

      // Close loading indicator
      if (context.mounted) {
        Navigator.pop(context);

        // Show success dialog with file path
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Export Successful'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('File saved successfully!'),
                    const SizedBox(height: 8),
                    Text(
                      'Location: $filePath',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Close loading indicator if it's showing
      if (context.mounted) {
        Navigator.pop(context);

        // Show error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Export Error'),
              content: Text('Failed to export analytics: $e'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }
}
