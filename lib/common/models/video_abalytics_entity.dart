import 'package:course_app/common/models/user.dart';
import 'package:course_app/common/models/watch_session_entity.dart';

class VideoAnalytics {
  final String courseId;
  final String courseVideoId;
  final String videoId;
  final List<WatchSession> watchSessions;
  final String totalWatchTime;
  final int pauseCount;
  final UserProfile userProfile;
  final int totalVideosInCourse;
  VideoAnalytics({
    required this.courseId,
    required this.courseVideoId,
    required this.videoId,
    required this.watchSessions,
    required this.totalWatchTime,
    required this.pauseCount,
    required this.userProfile,
    required this.totalVideosInCourse,
  });

  Map<String, dynamic> toJson() => {
        'courseId': courseId,
        'courseVideoId': courseVideoId,
        'videoId': videoId,
        'watchSessions':
            watchSessions.map((session) => session.toJson()).toList(),
        'totalWatchTime': totalWatchTime,
        'pauseCount': pauseCount,
        'userProfile': userProfile.toJson(),
        'totalVideosInCourse': totalVideosInCourse,
      };

  factory VideoAnalytics.fromJson(Map<String, dynamic> json) => VideoAnalytics(
        courseId: json['courseId'],
        courseVideoId: json['courseVideoId'],
        videoId: json['videoId'],
        watchSessions: (json['watchSessions'] as List)
            .map((session) => WatchSession.fromJson(session))
            .toList(),
        totalWatchTime: json['totalWatchTime'],
        pauseCount: json['pauseCount'],
        userProfile: UserProfile.fromJson(json['userProfile']),
        totalVideosInCourse: json['totalVideosInCourse'],
      );
}
