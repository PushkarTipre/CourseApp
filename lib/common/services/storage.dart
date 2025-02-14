import 'dart:convert';
import 'dart:developer';
import 'package:course_app/common/models/entities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class StorageService {
  late final SharedPreferences _pref;

  Future<StorageService> init() async {
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(String key, String value) async {
    return await _pref.setString(key, value);
  }

  String getString(String key) {
    return _pref.getString(key) ?? "";
  }

  String getUserToken() {
    return _pref.getString(AppConstants.STORAGE_USER_TOKEN_KEY) ?? "";
  }

  Future<bool> setBool(String key, bool value) async {
    return await _pref.setBool(key, value);
  }

  bool getDeviceFirstOpen() {
    return _pref.getBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_KEY) ?? false;
  }

  bool isLoggedIn() {
    return _pref.getString(AppConstants.STORAGE_USER_PROFILE_KEY) != null;
  }

  UserProfile getUserProfile() {
    var profile = _pref.getString(AppConstants.STORAGE_USER_PROFILE_KEY) ?? "";
    if (profile.isEmpty) {
      return UserProfile(); // Return a default UserProfile if no profile is stored
    }
    var profileJson = jsonDecode(profile);
    return UserProfile.fromJson(profileJson);
  }

  Future<bool> remove(String key) async {
    return await _pref.remove(key);
  }

  Future<bool> saveVideoPauseTimestamp(
      String courseVideoId, String timestamp) async {
    List<String> timestamps = getVideoPauseTimestamps(courseVideoId);
    String newEntry = jsonEncode({
      'timestamp': timestamp,
      'datetime': DateTime.now().toIso8601String(),
    });
    timestamps.add(newEntry);
    return await _pref.setStringList('video_pause_$courseVideoId', timestamps);
  }

  List<String> getVideoPauseTimestamps(String courseVideoId) {
    return _pref.getStringList('video_pause_$courseVideoId') ?? [];
  }

  List<Map<String, dynamic>> getFormattedVideoPauseTimestamps(
      String courseVideoId) {
    List<String> rawTimestamps = getVideoPauseTimestamps(courseVideoId);
    return rawTimestamps.map((rawData) {
      Map<String, dynamic> data = jsonDecode(rawData);
      return data;
    }).toList();
  }

  Future<bool> markVideoAsCompleted(
      String courseId, String courseVideoId) async {
    // Store completion status for the video using SharedPreferences
    return await _pref.setBool(
        'completed_course_${courseId}_video_$courseVideoId', true);
  }

  bool isVideoCompleted(String courseId, String courseVideoId) {
    // Check if a video is marked as completed
    return _pref.getBool('completed_course_${courseId}_video_$courseVideoId') ??
        false;
  }

  Future<bool> saveVideoCompletionTimestamp(
      String courseId, String courseVideoId) async {
    // Save the timestamp when the video was completed
    return await _pref.setString(
        'completion_timestamp_course_${courseId}_video_$courseVideoId',
        DateTime.now().toIso8601String());
  }

  String? getVideoCompletionTimestamp(String courseId, String courseVideoId) {
    // Retrieve the completion timestamp for a video
    return _pref.getString(
        'completion_timestamp_course_${courseId}_video_$courseVideoId');
  }

  // Method to get all completed videos for a specific course
  List<String> getCompletedVideosForCourse(String courseId) {
    List<String> completedVideos = [];

    _pref.getKeys().forEach((key) {
      if (key.startsWith('completed_course_${courseId}_video_')) {
        // Extract the video ID from the key
        String videoId =
            key.replaceFirst('completed_course_${courseId}_video_', '');
        completedVideos.add(videoId);
      }
    });

    return completedVideos;
  }

  // Method to clear timestamps for a specific video
  Future<bool> clearVideoTimestamps(String courseVideoId) async {
    return await _pref.remove('video_pause_$courseVideoId');
  }

  // Method to get all video IDs that have pause timestamps
  List<String> getAllVideosWithTimestamps() {
    return _pref
        .getKeys()
        .where((key) => key.startsWith('video_pause_'))
        .map((key) => key.replaceFirst('video_pause_', ''))
        .toList();
  }

  // Method to get statistics for a video
  Map<String, dynamic> getVideoStatistics(String courseVideoId) {
    List<Map<String, dynamic>> timestamps =
        getFormattedVideoPauseTimestamps(courseVideoId);

    return {
      'total_pauses': timestamps.length,
      'timestamps': timestamps,
      'video_id': courseVideoId,
    };
  }

  void clearAllVideoTimestamps() {
    try {
      // Get all video IDs with timestamps
      List<String> videosWithData = getAllVideosWithTimestamps();

      // Clear data for each video
      for (String videoId in videosWithData) {
        String key =
            'video_pause_$videoId'; // Changed from 'video_timestamps_$videoId'
        _pref.remove(key); // Using _pref.remove directly
      }

      log('Cleared timestamps for ${videosWithData.length} videos');
    } catch (e) {
      log('Error clearing timestamps: $e');
    }
  }
}
