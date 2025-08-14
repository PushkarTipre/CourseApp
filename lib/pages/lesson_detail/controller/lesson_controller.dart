import 'dart:developer';

import 'package:better_player/better_player.dart';
import 'package:course_app/common/models/lesson_entities.dart';

import 'package:course_app/global.dart';
// import 'package:better_player_enhanced/better_player.dart';
import 'package:course_app/pages/lesson_detail/repo/lesson_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/services/storage.dart';
import '../lesson_time/repo/analytics.dart';

part 'lesson_controller.g.dart';

//Part-1
BetterPlayerController? videoPlayerController;
bool isRestart = false;
final storageService = StorageService().init();
@riverpod
Future<void> lessonDetailController(LessonDetailControllerRef ref,
    {required int index}) async {
  LessonRequestEntity lessonRequestEntity = LessonRequestEntity();
  lessonRequestEntity.id = index;
  final response =
      await LessonRepo.courseLessonDetail(params: lessonRequestEntity);
  if (response.code == 200) {
    var url = response.data!.elementAt(0).url!;

    int courseVideoId = int.parse(response.data!.elementAt(0).course_video_id!);
    // Update the video index with correct ID immediately
    ref
        .read(lessonDataControllerProvider.notifier)
        .updateCurrentVideoIndex(courseVideoId);
    // If this is a restart, trigger a new screen navigation in analytics
    if (isRestart) {
      ref
          .read(lessonDataControllerProvider.notifier)
          .analyticsService
          .onEnterVideoScreen();
    }
    videoPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          autoDetectFullscreenAspectRatio: true,
          fit: BoxFit.fill,
          autoPlay: true,
          expandToFill: true,
          startAt: const Duration(seconds: 0),
          controlsConfiguration: BetterPlayerControlsConfiguration(
            enableProgressBar: true,
            enableProgressText: true,
            enablePlayPause: true,
            enableSkips: false,
            enableFullscreen: true,
            enableMute: true,
            enableOverflowMenu: true,
            enableProgressBarDrag: false,
            enableRetry: isRestart,
          ),
        ),
        betterPlayerDataSource: BetterPlayerDataSource.network(url));

    var initializeVideoPlayerFuture = videoPlayerController
        ?.setupDataSource(BetterPlayerDataSource.network(url));

    LessonVideo vidInstance = LessonVideo(
      lessonItem: response.data!,
      isPlay: true,
      initializeVideoPlayer: initializeVideoPlayerFuture,
      url: url,
    );
    videoPlayerController?.play();
    ref.read(lessonDataControllerProvider.notifier)._addEventListener();
    videoPlayerController?.addEventsListener((BetterPlayerEvent event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.pause) {
        logPauseTimestamp(ref);
      }
    });

    ref
        .read(lessonDataControllerProvider.notifier)
        .updateLessonData(vidInstance);
  } else {
    print('request failed ${response.code}');
  }
}

void logPauseTimestamp(LessonDetailControllerRef ref) {
  if (videoPlayerController != null) {
    final position =
        videoPlayerController!.videoPlayerController?.value.position;
    if (position != null) {
      String timestamp = _formatDuration(position);
      print('Video paused at: $timestamp');

      // Update the LessonVideo instance with the new timestamp
      ref
          .read(lessonDataControllerProvider.notifier)
          .updateLastPausedAt(timestamp);
    }
  }
}

String _formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

//PART-2
@riverpod
class LessonDataController extends _$LessonDataController {
  late final VideoAnalyticsService analyticsService;
  String _lastLoggedTimestamp = '';
  String lastPausedTimestamp = '0:00';
  int currentVideoIndex = 0;
  bool isLoggingInProgress = false;
  int? _courseId;
  int _totalVideosInCourse = 0; // Add this property

  void setCourseId(int courseId) {
    _courseId = courseId;
  }

  void setTotalVideosInCourse(int count) {
    _totalVideosInCourse = count;
    log("Set total videos in course to: $_totalVideosInCourse");
  }

  int? get courseId => _courseId;

  @override
  FutureOr<LessonVideo> build() async {
    // Initialize analytics service
    analyticsService = VideoAnalyticsService(Global.storageService);

    // Signal that this is a new screen navigation
    analyticsService.onEnterVideoScreen();

    ref.onDispose(() {
      _removeEventListener();
      videoPlayerController?.dispose();
    });
    return LessonVideo();
  }

  void updateCurrentVideoIndex(int videoId) {
    currentVideoIndex = videoId; // Store the actual video ID, not the index

    // Log the update for debugging
    if (state.value?.lessonItem != null && state.value!.lessonItem.isNotEmpty) {
      log("Updated current video ID to: $videoId");
    }
  }

  @override
  set state(AsyncValue<LessonVideo> newState) {
    // TODO: implement state
    super.state = newState;
  }

  void updateLastPausedAt(String timestamp) {
    update((data) => data.copyWith(lastPausedAt: timestamp));
  }

  void updateLessonData(LessonVideo lessons) {
    update((data) => lessons);
    /* update((data)=>data.copyWith(
      url:lessons.url,
      initializeVideoPlayer: lessons.initializeVideoPlayer,
      lessonItem: lessons.lessonItem,
      isPlay: lessons.isPlay
    ));*/
  }

  void playPause(bool isPlay) {
    // update((data) => data.copyWith(isPlay: isPlay));
    state = AsyncData(state.value!.copyWith(isPlay: isPlay));
    if (!isPlay) {
      // Log the timestamp when the video is paused
      logPauseTimestamp();
    } else if (isRestart) {
      // If this is a restart, inform the analytics service
      analyticsService.onVideoRestart();
      isRestart = false; // Reset the restart flag
    }
  }

  void logPauseTimestamp() {
    if (videoPlayerController != null) {
      final position =
          videoPlayerController!.videoPlayerController?.value.position;
      final duration =
          videoPlayerController!.videoPlayerController?.value.duration;

      if (position != null && duration != null) {
        String currentTimestamp = formatDuration(position);

        // Check if this timestamp at this position has already been logged
        if (currentTimestamp == _lastLoggedTimestamp) {
          isLoggingInProgress = false;
          return;
        }

        _lastLoggedTimestamp = currentTimestamp;
        lastPausedTimestamp = formatDuration(position);
        log('Video paused at: $lastPausedTimestamp');

        if (state.value?.lessonItem != null &&
            state.value!.lessonItem.isNotEmpty) {
          String courseVideoId = currentVideoIndex.toString();
          log("Logging pause event for course_video_id: $courseVideoId and courseId: $_courseId");

          // String courseVideoId = state
          //     .value!.lessonItem[currentVideoIndex].course_video_id
          //     .toString();
          // log("Current course_video_id: $currentVideoIndex");

          // Log to analytics service with proper duration information
          analyticsService.logPauseEvent(
              courseId.toString(), courseVideoId, position, duration);

          // Generate and print report for debugging
          log("Generating report for course_video_id: $courseVideoId");
          analyticsService
              .generateAnalyticsReport(courseId.toString(), courseVideoId)
              .then((report) {
            print('Analytics Report: $report');
          });

          // Also save to existing storage if needed
          Global.storageService
              .saveVideoPauseTimestamp(courseVideoId, lastPausedTimestamp);
        }

        update((data) => data.copyWith(lastPausedAt: lastPausedTimestamp));
      }
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  // String get lastPausedTimestamp => lastPausedTimestamp;

  void playNextVid(String url) async {
    _removeEventListener();
    if (videoPlayerController != null) {
      videoPlayerController?.pause();
      videoPlayerController?.dispose();
    }
    update((data) => data.copyWith(
          isPlay: false,
          initializeVideoPlayer: null,
        ));

    // Reset the last logged timestamp when changing videos
    _lastLoggedTimestamp = '';
    isLoggingInProgress = false;

    // Signal that this is a new video/screen navigation
    analyticsService.onEnterVideoScreen();

    // Make sure the video ID is updated before starting the new video
    if (state.value?.lessonItem != null) {
      for (var i = 0; i < state.value!.lessonItem.length; i++) {
        if (state.value!.lessonItem[i].url == url) {
          updateCurrentVideoIndex(
              int.parse(state.value!.lessonItem[i].course_video_id!));
          break;
        }
      }
    }

    var vidUrl = url;
    videoPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(
            autoDetectFullscreenAspectRatio: true,
            fit: BoxFit.fill,
            autoPlay: true,
            expandToFill: true,
            startAt: Duration(seconds: 0),
            controlsConfiguration: BetterPlayerControlsConfiguration(
              enableProgressBar: true,
              enableProgressText: true,
              enablePlayPause: true,
              enableSkips: false,
              enableFullscreen: true,
              enableMute: true,
              enableOverflowMenu: true,
              enableProgressBarDrag: false,
              enableRetry: true,
            )),
        betterPlayerDataSource: BetterPlayerDataSource.network(url));

    var initializeVideoPlayerFuture = videoPlayerController
        ?.setupDataSource(BetterPlayerDataSource.network(vidUrl));

    state = AsyncData(state.value!.copyWith(
      initializeVideoPlayer: initializeVideoPlayerFuture,
      isPlay: true,
      url: url,
    ));
    _addEventListener();
  }

  void _onPlayerEvent(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.pause) {
      playPause(false);
      logPauseTimestamp();
    } else if (event.betterPlayerEventType == BetterPlayerEventType.play) {
      if (isRestart) {
        // Handle restart specific logic
        analyticsService.onVideoRestart();
        isRestart = false;
      }
      log("Total videos in course in controller: $_totalVideosInCourse");
      analyticsService.logPlayStart(
        courseId: courseId.toString(),
        videoId: currentVideoIndex.toString(),
        totalVideosInCourse: _totalVideosInCourse,
      );
      playPause(true);
    } else if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
      _handleVideoCompletion();
    }
  }

  void _handleVideoCompletion() {
    // Set the play state to false to show restart/play icon
    playPause(false);

    if (state.value?.lessonItem != null && state.value!.lessonItem.isNotEmpty) {
      String courseVideoId = currentVideoIndex.toString();

      // Log completion event and set up for restart
      analyticsService.logCompletionEvent(courseId.toString(), courseVideoId);

      // Mark video as completed
      Global.storageService
          .markVideoAsCompleted(courseId.toString(), courseVideoId);

      // Generate and print report
      analyticsService
          .generateAnalyticsReport(courseId.toString(), courseVideoId)
          .then((report) {
        print('Video Completion Report: $report');
      });

      // Save completion timestamp
      Global.storageService
          .saveVideoCompletionTimestamp(courseId.toString(), courseVideoId);

      // Set isRestart flag for the video player
      isRestart = true;
    }
  }

  void _addEventListener() {
    videoPlayerController?.addEventsListener(_onPlayerEvent);
  }

  void _removeEventListener() {
    videoPlayerController?.removeEventsListener(_onPlayerEvent);
  }

  void analyzeVideoData() {
    List<String> videosWithData =
        Global.storageService.getAllVideosWithTimestamps();

    for (String videoId in videosWithData) {
      log('\nVideo $videoId - course_video_id = $videoId');

      Map<String, dynamic> stats =
          Global.storageService.getVideoStatistics(videoId);
      List<Map<String, dynamic>> timestamps = stats['timestamps'];

      // Group timestamps by watch session (using date)
      Map<String, List<String>> watchSessions = {};

      for (var entry in timestamps) {
        String datetime = entry['datetime'];
        String timestamp = entry['timestamp'];
        String dateOnly =
            DateTime.parse(datetime).toLocal().toString().split(' ')[0];

        watchSessions.putIfAbsent(dateOnly, () => []);
        watchSessions[dateOnly]!.add(timestamp);
      }

      // Print timestamps grouped by watch session
      int watchCount = 1;
      watchSessions.forEach((date, times) {
        log('\nWatch $watchCount:');
        for (var time in times) {
          log('Video paused at $time');
        }
        watchCount++;
      });
    }
  }
}
