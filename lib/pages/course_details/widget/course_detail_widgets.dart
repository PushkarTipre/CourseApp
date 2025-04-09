import 'dart:developer';

import 'package:course_app/common/routes/app_routes_name.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/models/CheckVideoAccessResponseEntity.dart';
import '../../../common/models/course_enties.dart';
import '../../../common/models/lesson_entities.dart';
import '../../../common/utils/app_colors.dart';
import '../../../common/utils/constants.dart';

import '../../../common/widgets/image_widgets.dart';

import '../../lesson_detail/controller/lesson_controller.dart';
import '../repo/course_detail.dart';

class CourseDetailThumbnail extends StatelessWidget {
  final CourseItem courseItem;
  const CourseDetailThumbnail({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.w,
      height: 220.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Main Image
            Image.network(
              "${AppConstants.IMAGE_UPLOADS_PATH}${courseItem.thumbnail}",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.primaryElement.withOpacity(0.1),
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 50.sp,
                  color: AppColors.primaryElement,
                ),
              ),
            ),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 15.h,
              left: 8.w,
              child: Container(
                width: 310.w,
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: Colors.white.withOpacity(0.85),
                ),
                child: Text(
                  courseItem.name ?? "Course Title",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseDetailIconText extends StatelessWidget {
  final CourseItem courseItem;
  const CourseDetailIconText({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      width: 340.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Author Button
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutesName.AUTHOR_PAGE,
                  arguments: {"token": courseItem.user_token});
            },
            borderRadius: BorderRadius.circular(30.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.primaryElement,
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryElement.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 16.sp,
                    color: Colors.white,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "Author Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Stats Container
          // Row(
          //   children: [
          //     // Followers
          //     Container(
          //       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(20.r),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black.withOpacity(0.05),
          //             blurRadius: 10,
          //             offset: const Offset(0, 2),
          //           ),
          //         ],
          //       ),
          //       child: Row(
          //         children: [
          //           Icon(
          //             Icons.people,
          //             size: 16.sp,
          //             color: AppColors.primaryElement,
          //           ),
          //           SizedBox(width: 5.w),
          //           Text(
          //             courseItem.follow?.toString() ?? "0",
          //             style: TextStyle(
          //               color: AppColors.primaryText,
          //               fontSize: 12.sp,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     SizedBox(width: 10.w),
          //     // Rating
          //     Container(
          //       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(20.r),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black.withOpacity(0.05),
          //             blurRadius: 10,
          //             offset: const Offset(0, 2),
          //           ),
          //         ],
          //       ),
          //       child: Row(
          //         children: [
          //           Icon(
          //             Icons.star,
          //             size: 16.sp,
          //             color: Colors.amber,
          //           ),
          //           SizedBox(width: 5.w),
          //           Text(
          //             courseItem.score?.toString() ?? "0",
          //             style: TextStyle(
          //               color: AppColors.primaryText,
          //               fontSize: 12.sp,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          //
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
      margin: EdgeInsets.only(top: 22.h),
      width: 340.w,
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
      padding: EdgeInsets.all(15.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                height: 20.h,
                width: 4.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryElement,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                "About This Course",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Course Name
          Text(
            courseItem.name ?? "No Name Available",
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
            ),
          ),
          SizedBox(height: 8.h),
          // Description
          Text(
            courseItem.description ?? "No Description Available",
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.primaryThreeElementText,
              height: 1.5,
            ),
          ),
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
      margin: EdgeInsets.only(top: 22.h),
      width: 340.w,
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
      padding: EdgeInsets.all(15.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                height: 20.h,
                width: 4.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryElement,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                "Course Includes",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          // Course Stats
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Video Hours
                _buildStatItem(
                  context,
                  Icons.play_circle_outline,
                  AppColors.primaryElement,
                  courseItem.video_length ?? 0,
                  "Hours Video",
                ),

                // Vertical Divider
                Container(
                  height: 40.h,
                  width: 1.w,
                  color: Colors.grey.withOpacity(0.3),
                ),

                // Lessons
                _buildStatItem(
                  context,
                  Icons.library_books_outlined,
                  Colors.orange,
                  courseItem.lesson_num ?? 0,
                  "Lessons",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, IconData icon, Color iconColor,
      int value, String label) {
    return Column(
      children: [
        Icon(
          icon,
          size: 28.sp,
          color: iconColor,
        ),
        SizedBox(height: 6.h),
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            color: AppColors.primaryThreeElementText,
          ),
        ),
      ],
    );
  }
}

class CourseInfo extends StatelessWidget {
  final String imagePath;
  final int? length;
  final String? infoText;
  final IconData? icon;
  final Color? iconColor;

  const CourseInfo({
    super.key,
    required this.imagePath,
    this.length,
    this.infoText = "",
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 18.w),
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
      child: Row(
        children: [
          // Left: Icon with gradient background
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  (iconColor ?? AppColors.primaryElement).withOpacity(0.8),
                  (iconColor ?? AppColors.primaryElement).withOpacity(0.4),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            alignment: Alignment.center,
            child: icon != null
                ? Icon(
                    icon,
                    color: Colors.white,
                    size: 24.sp,
                  )
                : AppImage(
                    imagePath: imagePath,
                    width: 24.w,
                    height: 24.h,
                  ),
          ),
          SizedBox(width: 18.w),
          // Right: Text info with improved typography
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  length == null ? "0" : length.toString(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryText,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  infoText ?? "",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryThreeElementText,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CourseDetailButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;

  const CourseDetailButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 18.h),
        width: 340.w,
        height: 56.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: backgroundColor != null
                ? [backgroundColor!, backgroundColor!.withOpacity(0.8)]
                : [
                    AppColors.primaryElement,
                    AppColors.primaryElement.withOpacity(0.8)
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: (backgroundColor ?? AppColors.primaryElement)
                  .withOpacity(0.25),
              blurRadius: 15,
              offset: const Offset(0, 6),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: textColor ?? Colors.white,
                  size: 22.sp,
                ),
                SizedBox(width: 10.w),
              ],
              Text(
                text,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
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
          return Container(
            margin: EdgeInsets.only(top: 18.h),
            height: 56.h,
            width: 340.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Center(
              child: SizedBox(
                width: 28.w,
                height: 28.h,
                child: CircularProgressIndicator(
                  strokeWidth: 3.w,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primaryElement,
                  ),
                ),
              ),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data?.hasAccess == true ||
            isEnrolled) {
          return const SizedBox(height: 0);
        }

        if (courseItem.is_free == 0) {
          return CourseDetailButton(
            text: text,
            icon: Icons.shopping_cart_outlined,
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutesName.BUY_COURSE,
                arguments: {"id": courseItem.id},
              );
            },
          );
        } else {
          return CourseDetailButton(
            text: "Enroll for Free",
            icon: Icons.school_outlined,
            backgroundColor: Colors.green.shade600,
            onTap: () async {
              try {
                // Show loading indicator with improved style
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => Center(
                    child: Container(
                      padding: EdgeInsets.all(24.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 20,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 44.w,
                            height: 44.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 3.w,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.primaryElement,
                              ),
                            ),
                          ),
                          SizedBox(height: 18.h),
                          Text(
                            "Enrolling...",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

                final response =
                    await CourseRepo.enrollInCourse(courseId: courseItem.id!);

                // Close loading dialog
                Navigator.of(context).pop();

                if (response.code == 200) {
                  // Update the enrollment status
                  ref
                      .read(enrollmentStatusProvider(courseItem.id!.toString())
                          .notifier)
                      .state = true;

                  // Show success dialog with improved design
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(24.r),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 80.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.green.shade600,
                                size: 60.sp,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "Successfully Enrolled!",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryText,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              "You now have access to all course content",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.sp,
                                height: 1.4,
                                color: AppColors.primaryThreeElementText,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Container(
                              width: double.infinity,
                              height: 54.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primaryElement,
                                    AppColors.primaryElement.withOpacity(0.8)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(50.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryElement
                                        .withOpacity(0.25),
                                    blurRadius: 15,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  borderRadius: BorderRadius.circular(50.r),
                                  child: Center(
                                    child: Text(
                                      "Start Learning",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  // Show error dialog with improved design
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      title: Text(
                        "Enrollment Failed",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                      content: Text(
                        response.msg ?? "Unknown error occurred",
                        style: TextStyle(
                          fontSize: 15.sp,
                          height: 1.4,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "OK",
                            style: TextStyle(
                              color: AppColors.primaryElement,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              } catch (e) {
                // Close loading dialog if open
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }

                log('Error enrolling in course: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'An error occurred',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    backgroundColor: Colors.red.shade700,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    margin: EdgeInsets.all(10.r),
                  ),
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
    // Show loading indicator with improved design
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: EdgeInsets.all(22.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
          child: SizedBox(
            width: 44.w,
            height: 44.h,
            child: CircularProgressIndicator(
              strokeWidth: 3.w,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primaryElement,
              ),
            ),
          ),
        ),
      ),
    );

    try {
      CheckVideoAccessResponseEntity accessResponse =
          await CourseRepo.checkVideoAccess(courseId: courseId);

      // Close loading dialog
      Navigator.of(context).pop();

      if (accessResponse.hasAccess ?? false) {
        ref.watch(lessonDetailControllerProvider(index: lesson.id!));
        Navigator.of(context).pushNamed("/lesson_detail", arguments: {
          "lessonID": lesson.id,
          "courseId": courseId,
          "description": lesson.description,
        });
      } else {
        log("Access denied: ${accessResponse.msg}");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            title: Text(
              "Access Required",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            content: Text(
              "You need to purchase or enroll in this course to access this lesson.",
              style: TextStyle(
                fontSize: 15.sp,
                height: 1.4,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Fixed the reference to courseItem
                  // Navigate to purchase page
                  Navigator.of(context).pushNamed(
                    AppRoutesName.BUY_COURSE,
                    arguments: {"id": courseId},
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryElement,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                ),
                child: Text(
                  "Enroll Now",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Close loading dialog
      Navigator.of(context).pop();

      log("Error checking access: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to check access. Please try again.',
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          margin: EdgeInsets.all(10.r),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h, bottom: 25.h),
      width: 340.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (lessonData.isNotEmpty) ...[
            Row(
              children: [
                Container(
                  height: 22.h,
                  width: 5.w,
                  decoration: BoxDecoration(
                    color: AppColors.primaryElement,
                    borderRadius: BorderRadius.circular(2.5.r),
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "Lessons List",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryText,
                    letterSpacing: 0.3,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryElement.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    "${lessonData.length} Lessons",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryElement,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],

          if (lessonData.isEmpty)
            Container(
              width: 340.w,
              height: 180.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 15,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.video_library_outlined,
                      size: 36.sp,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    "No lessons available yet",
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "Check back soon for new content",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),

          // Lessons List with improved styling
          if (lessonData.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: lessonData.length,
              itemBuilder: (_, index) {
                final lesson = lessonData[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 15.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18.r),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18.r),
                      onTap: () {
                        checkAccessAndNavigate(context, lesson);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(14.r),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Left: Thumbnail with play overlay and improved styling
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 80.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 10,
                                        spreadRadius: 0,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14.r),
                                    child: Image.network(
                                      "${lesson.thumbnail}",
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                        color: Colors.grey.shade200,
                                        child: Icon(
                                          Icons.play_circle_outline,
                                          color: AppColors.primaryElement,
                                          size: 32.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Play indicator with improved styling
                                Container(
                                  width: 36.w,
                                  height: 36.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
                                        spreadRadius: 0,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 22.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 16.w),

                            // Right: Text content with improved typography and layout
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Lesson number badge with improved styling
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryElement
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Text(
                                      "Lesson ${index + 1}",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primaryElement,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),

                                  // Lesson name with improved styling
                                  Text(
                                    lesson.name ?? "No Name Available",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryText,
                                      height: 1.3,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5.h),

                                  // Lesson description with improved styling
                                  Text(
                                    lesson.description ??
                                        "No Description Available",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      height: 1.4,
                                      color: AppColors.primaryThreeElementText,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),

                            // Right arrow icon with improved styling
                            Container(
                              width: 36.w,
                              height: 36.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 14.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
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
