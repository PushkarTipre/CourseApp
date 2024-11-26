import 'dart:developer';

import 'package:course_app/common/models/lesson_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' show sin;

import '../../../common/utils/app_colors.dart';

import '../../../common/utils/img_res.dart';
import '../../../common/widgets/app_shadows.dart';
import '../../../common/widgets/image_widgets.dart';
import '../../../common/widgets/text_widget.dart';
import '../../quiz.dart';
import '../controller/lesson_controller.dart';

class LessonVideos extends StatefulWidget {
  final List<LessonVideoItem> lessonData;
  final WidgetRef ref;
  final Function? syncVidIndex;
  const LessonVideos({
    super.key,
    required this.lessonData,
    required this.ref,
    required this.syncVidIndex,
  });

  @override
  State<LessonVideos> createState() => _LessonVideosState();
}

class _LessonVideosState extends State<LessonVideos>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Temporary function to simulate quiz presence
  bool hasQuiz(int index) {
    final lesson = widget.lessonData[index];
    return lesson.quiz != null || lesson.quiz_json != null;
  }

  // Function to play video
  void playVideo(int index) {
    widget.syncVidIndex?.call(index);
    var vidUrl = widget.lessonData[index].url;
    widget.ref.read(lessonDataControllerProvider.notifier).playNextVid(vidUrl!);
  }

  void openQuiz(int index) {
    // Navigate to quiz screen with quiz data
    final lesson = widget.lessonData[index];

    // Assuming you have a QuizScreen that takes quiz data
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizScreen(
                quizData: lesson.quiz_json?['content'] ?? [],
                quizPdf: lesson.quiz,
                lessonName: lesson.name ?? 'Lesson Quiz')));
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.lessonData.length,
      itemBuilder: (_, index) {
        final bool quizAvailable = hasQuiz(index);

        return Container(
          margin: EdgeInsets.only(top: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          width: 325.w,
          height: 80.h,
          decoration: appBoxShadow(
            radius: 10.w,
            color: const Color.fromRGBO(255, 255, 255, 1),
            bR: 3,
            sR: 2,
          ),
          child: Row(
            children: [
              // Make the main content (everything except the arrow) tappable for video
              Expanded(
                child: InkWell(
                  onTap: () => playVideo(index),
                  child: Row(
                    children: [
                      // Thumbnail with quiz indicator
                      Stack(
                        children: [
                          AppBoxDecorationImage(
                            height: 60.h,
                            width: 60.w,
                            imagePath: "${widget.lessonData[index].thumbnail}",
                            fit: BoxFit.fill,
                          ),
                          if (quizAvailable)
                            Positioned(
                              top: -5,
                              right: -5,
                              child: AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: 0.8 +
                                        (0.2 *
                                            sin(_controller.value * 3.14 * 2)),
                                    child: Container(
                                      padding: EdgeInsets.all(8.r),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.purple.shade400,
                                            Colors.pink.shade400,
                                          ],
                                          transform: GradientRotation(
                                              _controller.value * 2 * 3.14),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.purple.withOpacity(0.3),
                                            blurRadius: 8,
                                            spreadRadius: 2,
                                          )
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.quiz,
                                        size: 16.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                      SizedBox(width: 10.w),
                      // Content
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text13Normal(
                              text: widget.lessonData[index].name ??
                                  "No Name Available",
                              color: AppColors.primaryText,
                            ),
                            if (quizAvailable)
                              Container(
                                margin: EdgeInsets.only(top: 4.h),
                                child: AnimatedBuilder(
                                  animation: _controller,
                                  builder: (context, child) {
                                    return ShaderMask(
                                      shaderCallback: (bounds) =>
                                          LinearGradient(
                                        colors: [
                                          Colors.purple.shade400,
                                          Colors.pink.shade400,
                                          Colors.orange.shade400,
                                          Colors.purple.shade400,
                                        ],
                                        stops: [
                                          0.0,
                                          _controller.value,
                                          _controller.value + 0.3,
                                          1.0
                                        ],
                                      ).createShader(bounds),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 14.sp,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            'Quiz Available!',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Separate clickable arrow for quiz
              if (quizAvailable)
                InkWell(
                  onTap: () => openQuiz(index),
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.translate(
                          offset:
                              Offset(5 * sin(_controller.value * 3.14 * 2), 0),
                          child: ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.purple.shade400,
                                Colors.pink.shade400,
                              ],
                              transform: GradientRotation(
                                  _controller.value * 2 * 3.14),
                            ).createShader(bounds),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 24.sp,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
