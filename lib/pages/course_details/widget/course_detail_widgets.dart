import 'dart:developer';
import 'dart:ui';

import 'package:course_app/common/routes/app_routes_name.dart';
import 'package:course_app/common/utils/pop_messages.dart';
import 'package:course_app/common/widgets/button_widgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/models/CheckVideoAccessResponseEntity.dart';
import '../../../common/models/course_enties.dart';
import '../../../common/models/lesson_entities.dart';
import '../../../common/utils/app_colors.dart';
import '../../../common/utils/constants.dart';
import '../../../common/utils/img_res.dart';
import '../../../common/widgets/app_shadows.dart';
import '../../../common/widgets/image_widgets.dart';
import '../../../common/widgets/text_widget.dart';
import '../../lesson_detail/controller/lesson_controller.dart';
import '../repo/course_detail.dart';

class CourseDetailThumbnail extends StatelessWidget {
  final CourseItem courseItem;
  const CourseDetailThumbnail({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return AppBoxDecorationImage(
      imagePath: "${AppConstants.IMAGE_UPLOADS_PATH}${courseItem.thumbnail}",
      width: 325,
      height: 200,
      fit: BoxFit.fitWidth,
    );
  }
}

class CourseDetailIconText extends StatelessWidget {
  final CourseItem courseItem;
  const CourseDetailIconText({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      width: 325.w,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutesName.AUTHOR_PAGE,
                  arguments: {"token": courseItem.user_token});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              decoration: appBoxShadow(radius: 7.w),
              child: const Text10Normal(
                text: "Author Page",
                color: AppColors.primaryElementText,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.w),
            child: Row(
              children: [
                const AppImage(imagePath: Img_Res.people),
                Text11Normal(
                  text: courseItem.follow == null
                      ? "0"
                      : courseItem.follow.toString(),
                  color: AppColors.primaryThreeElementText,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.w),
            child: Row(
              children: [
                const AppImage(imagePath: Img_Res.star),
                Text11Normal(
                  text: courseItem.score == null
                      ? "0"
                      : courseItem.score.toString(),
                  color: AppColors.primaryThreeElementText,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CourseDetailDescription extends StatelessWidget {
  final CourseItem courseItem;
  const CourseDetailDescription({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text16Normal(
            text: courseItem.name ?? "No Name Available",
            color: AppColors.primaryText,
            align: TextAlign.left,
            weight: FontWeight.bold,
          ),
          Container(
            child: Text11Normal(
              text: courseItem.description ?? "No Description Available",
              color: AppColors.primaryThreeElementText,
            ),
          )
        ],
      ),
    );
  }
}

class CourseDetailIncludes extends StatelessWidget {
  final CourseItem courseItem;
  const CourseDetailIncludes({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        children: [
          const Text14Normal(
            text: "Course Includes",
            color: AppColors.primaryText,
            weight: FontWeight.bold,
          ),
          SizedBox(
            height: 12.h,
          ),
          CourseInfo(
            imagePath: Img_Res.videoDetail,
            length: courseItem.video_length,
            infoText: "Hours Videos",
          ),
          SizedBox(
            height: 10.h,
          ),
          CourseInfo(
            imagePath: Img_Res.fileDetail,
            length: courseItem.lesson_num,
            infoText: "Lessons",
          ),
          SizedBox(
            height: 10.h,
          ),
          CourseInfo(
            imagePath: Img_Res.downloadDetail,
            length: courseItem.down_num,
            infoText: "Number of Downloads",
          )
        ],
      ),
    );
  }
}

class CourseInfo extends StatelessWidget {
  final String imagePath;
  final int? length;
  final String? infoText;
  const CourseInfo(
      {super.key, required this.imagePath, this.length, this.infoText = ""});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          child: AppImage(
            imagePath: imagePath,
            width: 30.w,
            height: 30.h,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.w),
          child: Text11Normal(
            text: length == null ? "0 $infoText" : "$length $infoText",
            color: AppColors.primaryThreeElementText,
          ),
        ),
      ],
    );
  }
}

class CourseDetailButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CourseDetailButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 10.h),
        child: AppButton(
          text: text,
        ),
      ),
    );
  }
}

final enrollmentStatusProvider =
    StateProvider.family<bool, String>((ref, courseId) => false);

class CourseDetailGoBuyButton extends ConsumerWidget {
  final CourseItem courseItem;
  final String text;
  const CourseDetailGoBuyButton({
    super.key,
    required this.courseItem,
    this.text = "Go Buy",
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnrolled =
        ref.watch(enrollmentStatusProvider(courseItem.id!.toString()));
    log("Course free or not: ${courseItem.is_free}");

    return FutureBuilder(
      future: CourseRepo.checkVideoAccess(courseId: courseItem.id!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 20.h,
          );
        }

        if (snapshot.hasData && snapshot.data?.hasAccess == true ||
            isEnrolled) {
          return SizedBox(
            height: 20.h,
          );
        }

        if (courseItem.is_free == 0) {
          return CourseDetailButton(
            text: text,
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutesName.BUY_COURSE,
                arguments: {"id": courseItem.id},
              );
            },
          );
        } else {
          return CourseDetailButton(
            text: "Free",
            onTap: () async {
              try {
                final response =
                    await CourseRepo.enrollInCourse(courseId: courseItem.id!);
                if (response.code == 200) {
                  // Update the enrollment status
                  ref
                      .read(enrollmentStatusProvider(courseItem.id!.toString())
                          .notifier)
                      .state = true;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Successfully enrolled in course')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Enrollment failed')),
                  );
                }
              } catch (e) {
                log('Error enrolling in course: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('An error occurred')),
                );
              }
            },
          );
        }
      },
    );
  }
}

class LessonInfo extends StatelessWidget {
  final List<LessonItem> lessonData;
  final WidgetRef ref;
  final int courseId;
  const LessonInfo({
    super.key,
    required this.lessonData,
    required this.ref,
    required this.courseId,
  });

  Future<void> checkAccessAndNavigate(
      BuildContext context, LessonItem lesson) async {
    CheckVideoAccessResponseEntity accessResponse =
        await CourseRepo.checkVideoAccess(courseId: courseId);

    if (accessResponse.hasAccess ?? false) {
      ref.watch(lessonDetailControllerProvider(index: lesson.id!));
      Navigator.of(context).pushNamed("/lesson_detail", arguments: {
        "lessonID": lesson.id,
        "courseId": courseId,
        "description": lesson.description,
      });
    } else {
      log("Access denied for you: ${accessResponse.msg}");
      toastInfo("You need to purchase the course to access this lesson");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          lessonData.isNotEmpty
              ? const Text14Normal(
                  text: "Lessons List",
                  color: AppColors.primaryText,
                  weight: FontWeight.bold,
                )
              : const SizedBox(),
          SizedBox(
            height: 10.h,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: lessonData.length,
            itemBuilder: (_, index) {
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
                child: InkWell(
                  onTap: () {
                    checkAccessAndNavigate(context, lessonData[index]);
                  },
                  child: Row(
                    children: [
                      AppBoxDecorationImage(
                        height: 60.h,
                        width: 60.w,
                        imagePath: "${lessonData[index].thumbnail}",
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text13Normal(
                              text:
                                  lessonData[index].name ?? "No Name Available",
                              color: AppColors.primaryText,
                            ),
                            Text10Normal(
                              text: lessonData[index].description ??
                                  "No Description Available",
                              color: AppColors.primaryText,
                            ),
                          ],
                        ),
                      ),
                      AppImage(
                        imagePath: Img_Res.arrowRight,
                        width: 24.w,
                        height: 24.h,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
