import 'dart:developer';
import 'dart:math' show sin;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/models/lesson_entities.dart';
import '../../../common/models/quiz_start_request.dart';
import '../../../common/utils/app_colors.dart';

import '../../../common/widgets/app_shadows.dart';

import '../../../common/widgets/text_widget.dart';
import '../../quiz/controller/quiz_controller.dart';
import '../../quiz/view/quiz.dart';
import '../controller/lesson_controller.dart';

class LessonVideos extends ConsumerStatefulWidget {
  final List<LessonVideoItem> lessonData;
  final WidgetRef ref;
  final Function? syncVidIndex;
  final int courseId;
  final int lessonId;

  const LessonVideos({
    super.key,
    required this.lessonData,
    required this.ref,
    required this.syncVidIndex,
    required this.courseId,
    required this.lessonId,
  });

  @override
  ConsumerState<LessonVideos> createState() => _LessonVideosState();
}

class _LessonVideosState extends ConsumerState<LessonVideos>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  late AnimationController dialogController;
  late Animation<double> dialogAnimation;

  bool hasQuiz(int index) {
    final lesson = widget.lessonData[index];
    return lesson.quiz != null || lesson.quiz_json != null;
  }

  void playVideo(int index) {
    widget.syncVidIndex?.call(index);
    var vidUrl = widget.lessonData[index].url;
    widget.ref.read(lessonDataControllerProvider.notifier).playNextVid(vidUrl!);
  }

  void _showResultsDialog(int score) {
    dialogController.forward();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: ScaleTransition(
          scale: dialogAnimation,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                'Quiz Results',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TweenAnimationBuilder<double>(
                  duration: Duration
                      .zero, // This will show the final value immediately
                  tween: Tween<double>(begin: 0, end: score.toDouble()),
                  builder: (context, value, child) => Text(
                    'Score: ${value.toInt()}',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Reverse the animation before closing
                    await dialogController.reverse();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ).then((_) {
      // Only reset if the dialog was dismissed without using the button
      if (dialogController.status != AnimationStatus.dismissed) {
        dialogController.reset();
      }
    });
  }

  void showQuizInstructionsDialog(BuildContext context, int index) {
    final lesson = widget.lessonData[index];
    var startQuizParams = QuizStartRequestEntity(
      courseId: widget.courseId,
      courseVideoId: int.parse(lesson.course_video_id!),
      lessonId: widget.lessonId,
    );

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Quiz Instructions',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Before attempting the quiz, please read the following instructions carefully:'),
                SizedBox(height: 10),
                Text('1. You have only one attempt to complete this quiz.',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text('2. You cannot pause or resume the quiz once started.'),
                Text(
                    '3. If you exit the quiz you wont be able to restart the quiz and the score will be marked as 0.'),
                Text(
                    '4. Ensure you are in a quiet, distraction-free environment.'),
                Text(
                    '5. No external resources or help are allowed during the quiz.'),
                Text('6. Answer each question carefully.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            ElevatedButton(
              child: const Text('I Understand, Start Quiz'),
              onPressed: () async {
                // Close instructions dialog
                Navigator.of(dialogContext).pop();

                try {
                  final quizData = await ref.read(
                      startQuizControllerProvider(params: startQuizParams)
                          .future);

                  if (quizData != null && quizData.quiz?.completed == true) {
                    final score = quizData.quiz?.score ?? 0;

                    _showResultsDialog(score);
                  } else if (quizData?.quiz != null) {
                    final quizUniqueId = quizData!.quiz!.quizUniqueId;
                    log("Quiz unique ID: $quizUniqueId");

                    // Navigate to quiz screen
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(
                          quizData: lesson.quiz_json?['content'] ?? [],
                          quizPdf: lesson.quiz,
                          lessonName: lesson.name ?? 'Lesson Quiz',
                          quizUniqueId: quizUniqueId,
                        ),
                      ),
                    );
                  } else {
                    // Handle case where quiz data is null
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Failed to start the quiz.")),
                    );
                  }
                } catch (e) {
                  // Close loading dialog in case of error
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text("An error occurred while starting the quiz.")),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void openQuiz(int index) {
    // Navigate to quiz screen with quiz data
    showQuizInstructionsDialog(context, index);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    dialogController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    dialogAnimation = CurvedAnimation(
      parent: dialogController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    dialogController.dispose();
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
                              maxLines: 2,
                              text: widget.lessonData[index].name ??
                                  "No Name Available",
                              color: AppColors.primaryText,
                            ),
                            if (quizAvailable)
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 4.h),
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
