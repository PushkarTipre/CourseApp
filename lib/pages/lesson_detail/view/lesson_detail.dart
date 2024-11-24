import 'dart:async';
import 'dart:developer';

import 'package:better_player/better_player.dart';

import 'package:course_app/common/utils/img_res.dart';
import 'package:course_app/common/utils/pop_messages.dart';
import 'package:course_app/common/widgets/app_bar.dart';
import 'package:course_app/common/widgets/app_shadows.dart';
import 'package:course_app/common/widgets/image_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import '../../../common/services/storage.dart';
import '../../../csv_export.dart';
import '../../../global.dart';
import 'test.dart';
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

  late StorageService storageService;

  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  Future<void> unsecureScreen() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void initState() {
    super.initState();
    secureScreen();
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

    unsecureScreen();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   var courseId = ModalRoute.of(context)!.settings.arguments as Map;
  //   args = courseId["courseId"];
  //   super.didChangeDependencies();
  // }

  void syncVideoIndex(int index) {
    setState(() {
      videoIndex = index;
      if (ref.read(lessonDataControllerProvider).value?.lessonItem != null) {
        // Make sure we're getting the course_video_id from the correct index
        currentVideoId = ref
            .read(lessonDataControllerProvider)
            .value
            ?.lessonItem[index]
            .course_video_id;

        // Immediately update the controller's video index
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

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // final lessonId = args['id'];
    final courseId = args['courseId'];

    log(" courseId: $courseId");

    // ref.watch(lessonDetailControllerProvider(index: lessonId));

    // Store the courseId in your LessonDataController for later use
    ref.read(lessonDataControllerProvider.notifier).setCourseId(courseId);
    // log("Lesson detail page with course id: $args");
    secureScreen();
    // var lessonDetail = ref.watch(lessonDetailControllerProvider(index: args.toInt()));
    var lessonData = ref.watch(lessonDataControllerProvider);
    //ref.watch(videoIndexControllerProvider);
    return Scaffold(
        appBar: buildGlobalAppBar(title: "Lesson detail"),
        body: Center(
          child: lessonData.value == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      lessonData.when(
                          data: (data) {
                            if (currentVideoId == null &&
                                data.lessonItem.isNotEmpty) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                setState(() {
                                  currentVideoId =
                                      data.lessonItem[0].course_video_id;
                                });
                              });
                            }
                            return Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Container(
                                    // width: 325.w,
                                    // height: 200.h,
                                    decoration: data.lessonItem.isEmpty
                                        ? appBoxShadow()
                                        : networkImageDecoration(
                                            imagePath:
                                                "${data.lessonItem[0].thumbnail}"),
                                    // "${AppConstants.IMAGE_UPLOADS_PATH}${data.lessonItem[0].thumbnail}"),
                                    child: FutureBuilder(
                                      future: data.initializeVideoPlayer,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          currentVideoId = data
                                              .lessonItem[videoIndex]
                                              .course_video_id;
                                          log("This is the video id $currentVideoId");

                                          return videoPlayerController == null
                                              ? Container()
                                              : Stack(
                                                  children: [
                                                    BetterPlayer(
                                                      controller:
                                                          videoPlayerController!,
                                                    ),
                                                    Text(
                                                      'Last paused at: ${data.lastPausedAt}',
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),

                                                    // VideoPlayer(
                                                    //     videoPlayerController!),
                                                  ],
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
                                Text(
                                  'Last paused at: ${data.lastPausedAt}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                // In your settings screen or wherever you want to place the button
                                ElevatedButton(
                                  onPressed: () async {
                                    await analyticsService.clearAnalyticsData(
                                        courseId: courseId.toString(),
                                        courseVideoId: currentVideoId!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'All analytics data cleared!')),
                                    );
                                  },
                                  child: const Text('Clear All Analytics Data'),
                                ),

                                ElevatedButton(
                                    onPressed: () {
                                      log("Current video id: $currentVideoId");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              VideoAnalyticsScreen2(
                                            courseId: courseId.toString(),
                                            videoId: currentVideoId!,
                                            videoTitle: data
                                                .lessonItem[videoIndex].name!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text('View Analytics')),

                                ElevatedButton.icon(
                                  onPressed: () =>
                                      AnalyticsExportHandler.exportAnalytics(
                                          context),
                                  icon: const Icon(Icons.download),
                                  label: const Text('Export Analytics'),
                                ),

                                //video controls
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.w, right: 25.w, top: 10.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // videoIndex = videoIndex - 1;
                                          // if (videoIndex < 0) {
                                          //   videoIndex = 0;
                                          //   toastInfo("No earlier videos");
                                          //   return;
                                          // }
                                          // var videoUrl =
                                          //     data.lessonItem[videoIndex].url;
                                          // // ref
                                          // //     .read(lessonDataControllerProvider
                                          // //         .notifier)
                                          // //     .playNextVid(videoUrl!);
                                          //
                                          // onVideoChanged(videoUrl!);
                                          if (videoIndex > 0) {
                                            syncVideoIndex(videoIndex - 1);
                                            onVideoChanged(data
                                                .lessonItem[videoIndex].url!);
                                            ref
                                                .read(
                                                    lessonDataControllerProvider
                                                        .notifier)
                                                .playPause(true);
                                          } else {
                                            toastInfo("No earlier videos");
                                          }
                                        },
                                        child: AppImage(
                                          width: 24.w,
                                          height: 24.h,
                                          imagePath: Img_Res.left,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.h,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (data.isPlay) {
                                            videoPlayerController?.pause();
                                            ref
                                                .read(
                                                    lessonDataControllerProvider
                                                        .notifier)
                                                .playPause(false);
                                          } else {
                                            videoPlayerController?.play();
                                            ref
                                                .read(
                                                    lessonDataControllerProvider
                                                        .notifier)
                                                .playPause(true);
                                          }
                                        },
                                        child: data.isPlay
                                            ? AppImage(
                                                width: 24.w,
                                                height: 24.h,
                                                imagePath: Img_Res.pause,
                                              )
                                            : AppImage(
                                                width: 24.w,
                                                height: 24.h,
                                                imagePath: Img_Res.play_Circle),
                                      ),
                                      SizedBox(
                                        width: 15.h,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          videoIndex = videoIndex + 1;
                                          if (videoIndex >=
                                              data.lessonItem.length) {
                                            videoIndex =
                                                data.lessonItem.length - 1;
                                            toastInfo(
                                                "You have seen all the videos");
                                            return;
                                          }
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
                                        },
                                        child: AppImage(
                                          width: 24.w,
                                          height: 24.h,
                                          imagePath: Img_Res.right,
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 10.h,
                                ),
                                //video list
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 25.w, right: 25.w),
                                  child: LessonVideos(
                                      lessonData: data.lessonItem,
                                      ref: ref,
                                      syncVidIndex: syncVideoIndex),
                                )
                              ],
                            );
                          },
                          error: (e, t) => const Text("error"),
                          loading: () => const Text("Loading")),
                    ],
                  ),
                ),
        ));
  }

  String? currentVideoId;
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
