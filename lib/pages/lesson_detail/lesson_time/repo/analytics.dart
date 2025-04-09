import 'dart:convert';
import 'dart:developer';

import '../../../../common/models/pause_event_entity.dart';
import '../../../../common/models/user.dart';
import '../../../../common/models/video_abalytics_entity.dart';
import '../../../../common/models/watch_session_entity.dart';
import '../../../../common/services/storage.dart';
import '../../../../global.dart';

class VideoAnalyticsService {
  final StorageService _storage;
  static const String _analyticsKey = 'video_analysis_data';
  bool _isNewScreenNavigation = true; // Track screen navigation
  bool _isVideoRestart = false; // New flag to track video restarts
  DateTime? _actualStartTime;
  bool _isCurrentSessionValid = false; // New flag to track session validity

  String? _currentVideoId; // Track the current video being played

  VideoAnalyticsService(this._storage) {
    if (!_storage.isLoggedIn()) {
      throw Exception('User must be logged in to track video analytics');
    }
  }

  Map<String, dynamic> _generateEmptyReport() {
    return {
      'userInfo': UserProfile(
        id: '',
        name: null,
      ).toJson(),
      'totalSessions': 0,
      'totalPauses': 0,
      'commonPausePoints': <double>[],
      'averageViewingDuration': '0:00:00',
      'detailedSessions': [],
    };
  }

  void logPlayStart({required String courseId, required String videoId}) {
    _actualStartTime = DateTime.now();
    _isCurrentSessionValid = true; // Mark session as valid when playback starts

    // Track the current video ID
    final userProfile = Global.storageService.getUserProfile();
    _currentVideoId =
        '${userProfile.id}_${userProfile.name}_${courseId}_$videoId';

    // If this is a new video, ensure we treat it as a new session
    if (_currentVideoId != _currentVideoId) {
      _isNewScreenNavigation = true;
    }
  }

  void onEnterVideoScreen() {
    _isNewScreenNavigation = true;
    _isVideoRestart = false;
    _actualStartTime = null; // Reset the start time
    _isCurrentSessionValid = false; // Reset session validity
  }

  // New method to handle video restart
  void onVideoRestart() {
    _isVideoRestart = true;
    _isNewScreenNavigation = true; // Treat restart as new navigation
    _actualStartTime = null; // Reset the start time
    _isCurrentSessionValid = false; // Reset session validity
  }

  Future<void> logPauseEvent(String courseId, String videoId, Duration position,
      Duration totalDuration) async {
    try {
      final userProfile = Global.storageService.getUserProfile();
      final uniqueVideoId =
          '${userProfile.id}_${userProfile.name}_${courseId}_$videoId';

      // If video ID changed, force a new session
      if (_currentVideoId != uniqueVideoId) {
        _isNewScreenNavigation = true;
        _currentVideoId = uniqueVideoId;
      }

      final analytics = await _getVideoAnalytics(uniqueVideoId);
      final now = DateTime.now();

      // Determine if we need a new session
      bool needNewSession = analytics!.watchSessions.isEmpty ||
          !_isCurrentSessionValid ||
          _isNewScreenNavigation ||
          _isVideoRestart;

      WatchSession currentSession;
      if (needNewSession) {
        // Create a new session
        currentSession = WatchSession(
            date: _formatDate(_actualStartTime ?? now), // Use actual start time
            startTime: _formatTimestamp(
                _actualStartTime ?? now), // Use actual start time
            endTime: _formatTimestamp(now), // Current time for end
            pauseEvents: []);
        analytics.watchSessions.add(currentSession);
        _isCurrentSessionValid = true; // Mark the new session as valid
        _isNewScreenNavigation = false; // Reset flag
        _isVideoRestart = false; // Reset flag
      } else {
        // Use the existing session
        currentSession = analytics.watchSessions.last;
      }

      // Create pause event
      final pauseEvent = PauseEvent(
        timestamp: _formatTimestamp(now),
        duration: _formatDuration(position),
        videoProgress: (position.inSeconds / totalDuration.inSeconds) * 100,
      );

      // Update the session
      final updatedSession = WatchSession(
        date: currentSession.date,
        startTime: currentSession.startTime,
        endTime: _formatTimestamp(now), // Update end time to now
        pauseEvents: [...currentSession.pauseEvents, pauseEvent],
      );

      // Update analytics with the modified session
      final updatedSessions = List<WatchSession>.from(analytics.watchSessions);
      updatedSessions[updatedSessions.length - 1] = updatedSession;

      // Update analytics with new session
      final updatedAnalytics = VideoAnalytics(
        userProfile: analytics.userProfile,
        courseId: courseId,
        courseVideoId: videoId,
        videoId: uniqueVideoId,
        watchSessions: updatedSessions,
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
      final userProfile = Global.storageService.getUserProfile();
      final uniqueVideoId =
          '${userProfile.id}_${userProfile.name}_${courseId}_$videoId';
      final jsonData = json.encode(analytics.toJson());
      await _storage.setString('${_analyticsKey}_$uniqueVideoId', jsonData);
    } catch (e) {
      print('Error saving video analytics: $e');
    }
  }

  Future<Map<String, dynamic>> generateAnalyticsReport(
      String courseId, String videoId) async {
    try {
      final userProfile = Global.storageService.getUserProfile();
      final uniqueVideoId =
          '${userProfile.id}_${userProfile.name}_${courseId}_$videoId';
      final analytics = await _getVideoAnalytics(uniqueVideoId);

      // Calculate total pauses across all sessions
      final totalPauses = analytics?.watchSessions
          .fold(0, (sum, session) => sum + session.pauseEvents.length);

      // Find common pause points
      final commonPausePoints = _findCommonPausePoints(analytics!);

      // Calculate average viewing duration
      final averageViewingDuration =
          _calculateAverageViewingDuration(analytics);
      log('Analytics report generated successfully for video $uniqueVideoId.');
      return {
        'courseId': courseId,
        'courseVideoId': videoId,
        'uniqueVideoId': uniqueVideoId,
        'totalSessions': analytics.watchSessions.length,
        'totalPauses': totalPauses,
        'commonPausePoints': commonPausePoints,
        'averageViewingDuration': averageViewingDuration,
        'detailedSessions':
            analytics.watchSessions.map((s) => s.toJson()).toList(),
      };
    } catch (e) {
      print('Error generating analytics report: $e');
      return _generateEmptyReport();
    }
  }

  Future<VideoAnalytics?> _getVideoAnalytics(String videoId) async {
    try {
      final String data = await _storage.getString('${_analyticsKey}_$videoId');

      final parts = videoId.split('_');
      final userId = parts[0];
      final userName = parts[1];
      final courseId = parts[2];
      final courseVideoId = parts[3];
      log("User ID: $userId, User Name: $userName, Course ID: $courseId, Course Video ID: $courseVideoId");
      if (data.isEmpty) {
        log('No existing analytics found for video $videoId, creating initial analytics');
        return _createInitialAnalytics(courseId, courseVideoId, videoId);
      }

      try {
        final Map<String, dynamic> jsonData = json.decode(data);
        final analytics = VideoAnalytics.fromJson(jsonData);
        log('Successfully retrieved analytics for video $videoId: ${json.encode(analytics.toJson())}');
        return analytics;
      } catch (parseError) {
        log('Error parsing analytics data: $parseError');
        return _createInitialAnalytics(courseId, courseVideoId, videoId);
      }
    } catch (e) {
      log('Error retrieving video analytics: $e');
      return null;
      // return _createInitialAnalytics(videoId, courseId, courseVideoId);
    }
  }

  VideoAnalytics _createInitialAnalytics(
      String courseId, String courseVideoId, String uniqueVideoId) {
    final userProfile = Global.storageService.getUserProfile();
    return VideoAnalytics(
      courseId: courseId,
      courseVideoId: courseVideoId,
      videoId: uniqueVideoId,
      watchSessions: [],
      totalWatchTime: "0:00:00",
      pauseCount: 0,
      userProfile: UserProfile(
        id: userProfile.id ?? '',
        name: userProfile.name,
        token: userProfile.token,
      ),
    );
  }

  void logCompletionEvent(String courseId, String courseVideoId) {
    // Implement your completion logging logic
    // This could involve recording the full watch time, marking as completed, etc.
    log('Video Completed: Course $courseId, Video $courseVideoId');

    // Example: Save completion status
    Global.storageService.markVideoAsCompleted(courseId, courseVideoId);

    log('Video completion logged, restart flag set: $_isVideoRestart');
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

  String _formatDate(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }

  String _formatTimestamp(DateTime dateTime) {
    return "${_formatDate(dateTime)} "
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
  }

  Future<void> clearAnalyticsData(
      {String? courseId, String? courseVideoId}) async {
    try {
      if (courseId != null && courseVideoId != null) {
        final userProfile = Global.storageService.getUserProfile();
        final uniqueVideoId =
            '${userProfile.id}_${userProfile.name}_${courseId}_$courseVideoId';
        await _storage.remove('${_analyticsKey}_$uniqueVideoId');
        log('Cleared analytics for course $courseId, video $courseVideoId');
      }

      print("Analytics data cleared successfully.");
    } catch (e) {
      print("Error clearing analytics data: $e");
    }
  }
}
