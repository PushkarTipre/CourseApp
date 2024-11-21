// lib/services/video_analytics.dart

import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import '../../../../common/services/storage.dart'; // Update with your actual storage service import

// Models
class VideoAnalytics {
  final String videoId;
  final List<WatchSession> watchSessions;
  final String totalWatchTime;
  final int pauseCount;

  VideoAnalytics({
    required this.videoId,
    required this.watchSessions,
    required this.totalWatchTime,
    required this.pauseCount,
  });

  Map<String, dynamic> toJson() => {
        'videoId': videoId,
        'watchSessions':
            watchSessions.map((session) => session.toJson()).toList(),
        'totalWatchTime': totalWatchTime,
        'pauseCount': pauseCount,
      };

  factory VideoAnalytics.fromJson(Map<String, dynamic> json) => VideoAnalytics(
        videoId: json['videoId'],
        watchSessions: (json['watchSessions'] as List)
            .map((session) => WatchSession.fromJson(session))
            .toList(),
        totalWatchTime: json['totalWatchTime'],
        pauseCount: json['pauseCount'],
      );
}

class WatchSession {
  final String date;
  final String startTime;
  final String endTime;
  final List<PauseEvent> pauseEvents;

  WatchSession({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.pauseEvents,
  });

  Map<String, dynamic> toJson() => {
        'date': date,
        'startTime': startTime,
        'endTime': endTime,
        'pauseEvents': pauseEvents.map((event) => event.toJson()).toList(),
      };

  factory WatchSession.fromJson(Map<String, dynamic> json) => WatchSession(
        date: json['date'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        pauseEvents: (json['pauseEvents'] as List)
            .map((event) => PauseEvent.fromJson(event))
            .toList(),
      );
}

class PauseEvent {
  final String timestamp;
  final String duration;
  final double videoProgress;

  PauseEvent({
    required this.timestamp,
    required this.duration,
    required this.videoProgress,
  });

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'duration': duration,
        'videoProgress': videoProgress,
      };

  factory PauseEvent.fromJson(Map<String, dynamic> json) => PauseEvent(
        timestamp: json['timestamp'],
        duration: json['duration'],
        videoProgress: json['videoProgress'],
      );
}

class VideoAnalyticsService {
  final StorageService _storage;
  static const String _analyticsKey = 'video_analytics';
  bool _isNewScreenNavigation = true; // Track screen navigation

  VideoAnalyticsService(this._storage);

  // Call this when entering video screen
  void onEnterVideoScreen() {
    _isNewScreenNavigation = true;
  }

  Future<void> logPauseEvent(String courseId, String videoId, Duration position,
      Duration totalDuration) async {
    try {
      final uniqueVideoId = '$courseId-$videoId';
      final analytics = await _getVideoAnalytics(uniqueVideoId);
      final now = DateTime.now();

      // Create new session if this is a new screen navigation
      WatchSession currentSession;
      if (_isNewScreenNavigation) {
        currentSession = _createNewSession();
        analytics!.watchSessions.add(currentSession);
        _isNewScreenNavigation = false; // Reset flag
      } else {
        currentSession = analytics!.watchSessions.last;
      }

      // Update session end time
      final updatedSession = WatchSession(
        date: currentSession.date,
        startTime: currentSession.startTime,
        endTime: _formatTimestamp(now),
        pauseEvents: [
          ...currentSession.pauseEvents,
          PauseEvent(
            timestamp: _formatTimestamp(now),
            duration: _formatDuration(position),
            videoProgress: (position.inSeconds / totalDuration.inSeconds) * 100,
          ),
        ],
      );

      // Update analytics with new session
      final updatedAnalytics = VideoAnalytics(
        videoId: uniqueVideoId,
        watchSessions: [
          ...analytics.watchSessions
              .sublist(0, analytics.watchSessions.length - 1),
          updatedSession,
        ],
        totalWatchTime: _formatDuration(position),
        pauseCount: analytics.pauseCount + 1,
      );

      // Save updated analytics
      await _saveVideoAnalytics(courseId, videoId, updatedAnalytics);
    } catch (e) {
      print('Error logging pause event: $e');
    }
  }

  Future<void> _saveVideoAnalytics(
      String courseId, String videoId, VideoAnalytics analytics) async {
    try {
      final uniqueVideoId = '$courseId-$videoId';
      final jsonData = json.encode(analytics.toJson());
      await _storage.setString('${_analyticsKey}_$uniqueVideoId', jsonData);
    } catch (e) {
      print('Error saving video analytics: $e');
    }
  }

  Future<Map<String, dynamic>> generateAnalyticsReport(
      String courseId, String videoId) async {
    try {
      final uniqueVideoId = '$courseId-$videoId';
      final analytics = await _getVideoAnalytics(uniqueVideoId);

      // Calculate total pauses across all sessions
      final totalPauses = analytics?.watchSessions
          .fold(0, (sum, session) => sum + session.pauseEvents.length);

      // Find common pause points
      final commonPausePoints = _findCommonPausePoints(analytics!);

      // Calculate average viewing duration
      final averageViewingDuration =
          _calculateAverageViewingDuration(analytics!);
      log('Analytics report generated successfully for video $videoId.');
      return {
        'courseId': courseId,
        'courseVideoId': videoId,
        'totalSessions': analytics?.watchSessions.length,
        'totalPauses': totalPauses,
        'commonPausePoints': commonPausePoints,
        'averageViewingDuration': averageViewingDuration,
        'detailedSessions':
            analytics?.watchSessions.map((s) => s.toJson()).toList(),
      };
    } catch (e) {
      print('Error generating analytics report: $e');
      return _generateEmptyReport();
    }
  }

  // Future<Map<String, dynamic>> generateAnalyticsReport(String videoId) async {
  //   try {
  //     final analytics = await _getVideoAnalytics(videoId);
  //
  //     if (analytics == null) {
  //       return _generateEmptyReport();
  //     }
  //
  //     // Calculate total pauses across all sessions
  //     final totalPauses = analytics.watchSessions
  //         .fold(0, (sum, session) => sum + session.pauseEvents.length);
  //
  //     // Find common pause points
  //     final commonPausePoints = _findCommonPausePoints(analytics);
  //
  //     // Calculate average viewing duration
  //     final averageViewingDuration =
  //         _calculateAverageViewingDuration(analytics);
  //
  //     return {
  //       'totalSessions': analytics.watchSessions.length,
  //       'totalPauses': totalPauses,
  //       'commonPausePoints': commonPausePoints,
  //       'averageViewingDuration': averageViewingDuration,
  //       'detailedSessions':
  //           analytics.watchSessions.map((s) => s.toJson()).toList(),
  //     };
  //   } catch (e) {
  //     print('Error generating analytics report: $e');
  //     return _generateEmptyReport();
  //   }
  // }

  Map<String, dynamic> _generateEmptyReport() {
    return {
      'totalSessions': 0,
      'totalPauses': 0,
      'commonPausePoints': <double>[],
      'averageViewingDuration': '0:00:00',
      'detailedSessions': [],
    };
  }

  Future<VideoAnalytics?> _getVideoAnalytics(String videoId) async {
    try {
      final String data = await _storage.getString('${_analyticsKey}_$videoId');

      if (data == null || data.isEmpty) {
        log('No existing analytics found for video $videoId, creating initial analytics');
        return _createInitialAnalytics(videoId);
      }

      try {
        final Map<String, dynamic> jsonData = json.decode(data);
        final analytics = VideoAnalytics.fromJson(jsonData);
        log('Successfully retrieved analytics for video $videoId: ${json.encode(analytics.toJson())}');
        return analytics;
      } catch (parseError) {
        log('Error parsing analytics data: $parseError');
        return _createInitialAnalytics(videoId);
      }
    } catch (e) {
      log('Error retrieving video analytics: $e');
      return _createInitialAnalytics(videoId);
    }
  }

  VideoAnalytics _createInitialAnalytics(String videoId) {
    return VideoAnalytics(
      videoId: videoId,
      watchSessions: [_createNewSession()],
      totalWatchTime: "0:00:00",
      pauseCount: 0,
    );
  }

  WatchSession _createNewSession() {
    final now = DateTime.now();
    return WatchSession(
      date: _formatDate(now),
      startTime: _formatTimestamp(now),
      endTime: _formatTimestamp(now),
      pauseEvents: [],
    );
  }

  String _formatDate(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }

  String _formatTimestamp(DateTime dateTime) {
    return "${_formatDate(dateTime)} "
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
  }

  List<double> _findCommonPausePoints(VideoAnalytics analytics) {
    try {
      final Map<int, int> pausePointCounts = {};

      for (var session in analytics.watchSessions) {
        for (var pauseEvent in session.pauseEvents) {
          final roundedProgress = (pauseEvent.videoProgress / 5).round() * 5;
          pausePointCounts[roundedProgress] =
              (pausePointCounts[roundedProgress] ?? 0) + 1;
        }
      }

      return pausePointCounts.entries
          .where((entry) => entry.value > 1)
          .map((entry) => entry.key.toDouble())
          .toList()
        ..sort();
    } catch (e) {
      print('Error finding common pause points: $e');
      return [];
    }
  }

  String _calculateAverageViewingDuration(VideoAnalytics analytics) {
    try {
      if (analytics.watchSessions.isEmpty) return "0:00:00";

      int totalSeconds = 0;
      int validSessions = 0;

      for (var session in analytics.watchSessions) {
        final start = _parseTimeString(session.startTime);
        final end = _parseTimeString(session.endTime);

        if (start != null && end != null) {
          totalSeconds += end.difference(start).inSeconds;
          validSessions++;
        }
      }

      if (validSessions == 0) return "0:00:00";

      final averageSeconds = totalSeconds ~/ validSessions;
      return _formatDuration(Duration(seconds: averageSeconds));
    } catch (e) {
      print('Error calculating average viewing duration: $e');
      return "0:00:00";
    }
  }

  DateTime? _parseTimeString(String timeString) {
    try {
      return DateTime.parse(timeString);
    } catch (e) {
      print('Error parsing time string: $e');
      return null;
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  Future<void> clearAnalyticsData(
      {String? courseId, String? courseVideoId}) async {
    try {
      if (courseId != null && courseVideoId != null) {
        // Clear data for a specific video in a course
        final uniqueVideoId = '$courseId-$courseVideoId';
        await _storage.remove('${_analyticsKey}_$uniqueVideoId');
        log('Cleared analytics for course $courseId, video $courseVideoId');
      }

      print("Analytics data cleared successfully.");
    } catch (e) {
      print("Error clearing analytics data: $e");
    }
  }
}
