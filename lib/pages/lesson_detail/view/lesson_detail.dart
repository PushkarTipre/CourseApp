import 'dart:async';
import 'dart:developer';

import 'package:course_app/common/utils/pop_messages.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:better_player_enhanced/better_player.dart';
import '../../../common/models/lesson_entities.dart';
import '../../../common/services/storage.dart';
import '../../../common/utils/app_colors.dart';
import '../../../common/widgets/expandable.dart';
import '../../course_details/widget/course_detail_widgets.dart';

import '../../../global.dart';
import '../../csv_export/view/csv_export.dart';
import 'VideoAnalyticsScreen.dart';
import '../controller/lesson_controller.dart';
import '../lesson_time/repo/analytics.dart';

import '../widget/lesson_detail_widgets.dart';

class LessonDetail extends ConsumerStatefulWidget {
  const LessonDetail({super.key});

  @override
  ConsumerState<LessonDetail> createState() => _LessonDetailState();
}

class _LessonDetailState extends ConsumerState<LessonDetail> {
  int videoIndex = 0;
  String? currentVideoId;
  late StorageService storageService;
  bool isInitialized = false;

  // Future<void> secureScreen() async {
  //   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  // }
  //
  // Future<void> unsecureScreen() async {
  //   await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Extract arguments first to ensure they're available for the provider
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      final courseId = args['courseId'];
      log("Setting course ID in didChangeDependencies: $courseId");
      // Set the course ID which will trigger the data fetch
      ref.read(lessonDataControllerProvider.notifier).setCourseId(courseId);
    }
  }

  @override
  void initState() {
    super.initState();
    // secureScreen();
    initializeStorageService();
  }

  VideoAnalyticsService analyticsService =
      VideoAnalyticsService(Global.storageService);
  Future<void> initializeStorageService() async {
    storageService = await StorageService().init();
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();

    // unsecureScreen();
    super.dispose();
  }

  void syncVideoIndex(int index) {
    setState(() {
      videoIndex = index;
      if (ref.read(lessonDataControllerProvider).value?.lessonItem != null) {
        currentVideoId = ref
            .read(lessonDataControllerProvider)
            .value
            ?.lessonItem[index]
            .course_video_id;

        log("Current Video ID: $currentVideoId");

        ref
            .read(lessonDataControllerProvider.notifier)
            .updateCurrentVideoIndex(int.parse(currentVideoId!));

        log("Synced video index to $index");
        log("Synced video ID to $currentVideoId");
      }
    });
  }

  void onVideoChanged(String videoUrl) {
    ref.read(lessonDataControllerProvider.notifier).playNextVid(videoUrl);
  }

  void _initializeVideoIdFromData(LessonVideo data) {
    log("Initializing video ID from data");

    if (data.lessonItem.isNotEmpty) {
      setState(() {
        try {
          currentVideoId = data.lessonItem[videoIndex].course_video_id;
          log("Setting currentVideoId to: $currentVideoId");

          if (currentVideoId != null && currentVideoId!.isNotEmpty) {
            try {
              int parsedId = int.parse(currentVideoId!);
              ref
                  .read(lessonDataControllerProvider.notifier)
                  .updateCurrentVideoIndex(parsedId);
              log("Initial video ID set to $currentVideoId");
            } catch (e) {
              log("Error parsing currentVideoId: $e");
              currentVideoId = videoIndex.toString();
              log("Fallback: Using index as ID: $currentVideoId");
            }
          } else {
            currentVideoId = videoIndex.toString();
            log("Fallback: Initial video ID set to $currentVideoId");
          }

          isInitialized = true;
        } catch (e) {
          log("Error in initializeVideoId: $e");
          currentVideoId = "0";
          log("Error fallback: Setting currentVideoId to 0");
        }
      });
    } else {
      log("Cannot initialize video ID: lessonItem is empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final courseId = args['courseId'];
    final lessonId = args['lessonID'];
    final description = args['description'];
    final totalVideosInCourse = args['video_length'];

    log("LessonID: $lessonId");
    log("CourseID: $courseId");
    log("Description: $description");
    log("Total Videos in Course: ${totalVideosInCourse.runtimeType}");

    ref.read(lessonDataControllerProvider.notifier).setCourseId(courseId);
    // Add this line after setting the course ID
    ref
        .read(lessonDataControllerProvider.notifier)
        .setTotalVideosInCourse(totalVideosInCourse);
    final lessonDataAsync = ref.watch(lessonDataControllerProvider);

    // secureScreen();

    var lessonData = ref.watch(lessonDataControllerProvider);
    ref.listen<AsyncValue<LessonVideo?>>(
      lessonDataControllerProvider,
      (previous, current) {
        current.whenData((data) {
          if (data != null && data.lessonItem.isNotEmpty && !isInitialized) {
            log("Data received in listener, initializing video ID");
            _initializeVideoIdFromData(data);
          }
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lesson Detail",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: lessonData.value == null
          ? const Center(child: CircularProgressIndicator())
          : lessonData.when(
              data: (data) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Video Player Container
                        Container(
                          margin: EdgeInsets.only(top: 22.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 12,
                                spreadRadius: 1,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: FutureBuilder(
                                    future: data.initializeVideoPlayer,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return videoPlayerController == null
                                            ? Container()
                                            : BetterPlayer(
                                                controller:
                                                    videoPlayerController!,
                                              );
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   'Last Paused At: ${data.lastPausedAt}',
                                    //   style: TextStyle(
                                    //     fontSize: 14.sp,
                                    //     color:
                                    //         AppColors.primaryThreeElementText,
                                    //   ),
                                    // ),

                                    Text(
                                      'Lesson Title',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primaryText,
                                      ),
                                    ),
                                    Text(
                                      data.lessonItem.isNotEmpty
                                          ? data.lessonItem[videoIndex].name ??
                                              ""
                                          : "No title available",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColors.primaryText,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      'Lesson Description',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primaryText,
                                      ),
                                    ),
                                    ExpandableText(
                                      text: description,
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color:
                                            AppColors.primaryThreeElementText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Video Controls
                        Container(
                          margin: EdgeInsets.only(top: 22.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                spreadRadius: 1,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildVideoControlButton(
                                  icon: Icons.skip_previous,
                                  onTap: () {
                                    if (videoIndex > 0) {
                                      syncVideoIndex(videoIndex - 1);
                                      onVideoChanged(
                                          data.lessonItem[videoIndex].url!);
                                      ref
                                          .read(lessonDataControllerProvider
                                              .notifier)
                                          .playPause(true);
                                    } else {
                                      toastInfo(
                                          "You are at the beginning of the video list");
                                    }
                                  },
                                ),
                                _buildVideoControlButton(
                                  icon: data.isPlay
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  onTap: () {
                                    if (data.isPlay) {
                                      videoPlayerController?.pause();
                                      ref
                                          .read(lessonDataControllerProvider
                                              .notifier)
                                          .playPause(false);
                                    } else {
                                      videoPlayerController?.play();
                                      ref
                                          .read(lessonDataControllerProvider
                                              .notifier)
                                          .playPause(true);
                                    }
                                  },
                                ),
                                _buildVideoControlButton(
                                  icon: Icons.skip_next,
                                  onTap: () {
                                    if (videoIndex <
                                        data.lessonItem.length - 1) {
                                      videoIndex++;
                                      var videoUrl =
                                          data.lessonItem[videoIndex].url;
                                      ref
                                          .read(lessonDataControllerProvider
                                              .notifier)
                                          .playNextVid(videoUrl!);
                                      ref
                                          .read(lessonDataControllerProvider
                                              .notifier)
                                          .playPause(true);
                                    } else {
                                      toastInfo(
                                          "You have watched all the videos");
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Expanded(
                        //       child: CourseDetailButton(
                        //         text: 'Clear Analytics',
                        //         onTap: () async {
                        //           if (currentVideoId != null) {
                        //             // Clear specific video analytics
                        //             await analyticsService.clearAnalyticsData(
                        //               courseId: courseId.toString(),
                        //               courseVideoId: currentVideoId!,
                        //             );
                        //             ScaffoldMessenger.of(context).showSnackBar(
                        //               const SnackBar(
                        //                   content:
                        //                       Text('Video Analytics Cleared!')),
                        //             );
                        //           } else {
                        //             // Show a message that no video is selected
                        //             ScaffoldMessenger.of(context).showSnackBar(
                        //               const SnackBar(
                        //                   content: Text('No video selected')),
                        //             );
                        //           }
                        //         },
                        //         backgroundColor: Colors.redAccent,
                        //         icon: Icons.clear,
                        //       ),
                        //     ),
                        //     SizedBox(width: 10.w),
                        //     Expanded(
                        //       child: CourseDetailButton(
                        //         text: 'View Analytics',
                        //         onTap: () {
                        //           if (currentVideoId != null) {
                        //             Navigator.push(
                        //               context,
                        //               MaterialPageRoute(builder: (context) {
                        //                 // log("Current Video ID: $currentVideoId");
                        //                 return VideoAnalyticsScreen2(
                        //                   courseId: courseId.toString(),
                        //                   videoId: currentVideoId!,
                        //                   videoTitle:
                        //                       data.lessonItem[videoIndex].name!,
                        //                 );
                        //               }),
                        //             );
                        //           }
                        //         },
                        //         icon: Icons.analytics_outlined,
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        // CourseDetailButton(
                        //   text: ' Analytics',
                        //   onTap: () {
                        //     if (currentVideoId != null) {
                        //       // Navigator.push(
                        //       //   context,
                        //       //   MaterialPageRoute(builder: (context) {
                        //       //     // log("Current Video ID: $currentVideoId");
                        //       //     return const AnalyticsScreen();
                        //       //   }),
                        //       // );
                        //     }
                        //   },
                        //   icon: Icons.analytics_outlined,
                        // ),

                        // Video List
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: LessonVideos(
                            lessonData: data.lessonItem,
                            ref: ref,
                            syncVidIndex: syncVideoIndex,
                            courseId: courseId,
                            lessonId: lessonId!,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              error: (e, t) => Text("Error: $e"),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
    );
  }

  Widget _buildVideoControlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryElement,
              AppColors.primaryElement.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryElement.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}

class ClearVideoTimestampsButton extends StatefulWidget {
  const ClearVideoTimestampsButton({super.key});

  @override
  State<ClearVideoTimestampsButton> createState() =>
      _ClearVideoTimestampsButtonState();
}

class _ClearVideoTimestampsButtonState
    extends State<ClearVideoTimestampsButton> {
  void _clearTimestamps() {
    // Clear all video timestamps
    Global.storageService.clearAllVideoTimestamps();

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Video history cleared successfully'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: _clearTimestamps,
        icon: const Icon(Icons.delete_outline, size: 20),
        label: const Text('Clear Video History'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[600],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
