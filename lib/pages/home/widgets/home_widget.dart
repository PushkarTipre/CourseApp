import 'dart:developer';

import 'package:course_app/common/routes/app_routes_name.dart';
import 'package:course_app/common/utils/app_colors.dart';
import 'package:course_app/common/utils/constants.dart';
import 'package:course_app/common/utils/img_res.dart';
import 'package:course_app/common/widgets/app_shadows.dart';
import 'package:course_app/common/widgets/image_widgets.dart';
import 'package:course_app/common/widgets/text_widget.dart';
import 'package:course_app/pages/home/controller/home_controller.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/models/course_enties.dart';
import '../../../global.dart';

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: text24Normal(
          text: Global.storageService.getUserProfile().name ?? "",
          fontWeight: FontWeight.bold),
    );
  }
}

class HelloText extends StatelessWidget {
  final String text;
  final Color color;
  final int fontSize;

  const HelloText(
      {super.key,
      this.text = "Hello, ",
      this.color = AppColors.primaryThreeElementText,
      this.fontSize = 24});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: text24Normal(
        text: text,
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontSize.sp,
      ),
    );
  }
}

class HomeBanner extends ConsumerWidget {
  final PageController controller;
  final List<String> banners;
  final List<String> courseNames;
  final List<int> courseIds;

  const HomeBanner({
    super.key,
    required this.controller,
    required this.banners,
    required this.courseNames,
    required this.courseIds,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeScreenBannerIndex = ref.watch(homeScreenBannerIndexProvider);

    void onPageChanged(int index) {
      ref.read(homeScreenBannerIndexProvider.notifier).setIndex(index);
    }

    final hasBanners = banners.isNotEmpty;

    return Column(
      children: [
        if (hasBanners)
          Container(
            height: 340.h,
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: PageView.builder(
              controller: controller,
              itemCount: banners.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Card(
                    elevation: 8,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            Colors.grey.shade50,
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24.r),
                                ),
                                child: SizedBox(
                                  height: 180.h,
                                  width: double.infinity,
                                  child: ShaderMask(
                                    shaderCallback: (rect) {
                                      return const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.black,
                                          Colors.transparent
                                        ],
                                      ).createShader(
                                        Rect.fromLTRB(
                                            0, 0, rect.width, rect.height),
                                      );
                                    },
                                    blendMode: BlendMode.dstIn,
                                    child: Image.network(
                                      "${AppConstants.IMAGE_UPLOADS_PATH}${banners[index]}",
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) => Icon(
                                        Icons.image_not_supported_rounded,
                                        size: 48.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 16.h,
                                right: 16.w,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "${index + 1}/${banners.length}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(20.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    courseNames[index],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                      height: 1.2,
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          AppRoutesName.COURSE_DETAIL,
                                          arguments: {"id": courseIds[index]},
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.primaryElement,
                                        foregroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12.h,
                                        ),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: Text(
                                        "Continue Learning",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        else
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 24.h,
              horizontal: 16.w,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.school_outlined,
                  size: 48.sp,
                  color: Colors.grey,
                ),
                SizedBox(height: 16.h),
                Text(
                  "Ready to start learning?",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Purchase or apply for courses to begin your learning journey.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 16.h),
        if (hasBanners)
          DotsIndicator(
            dotsCount: banners.length,
            position: homeScreenBannerIndex,
            decorator: DotsDecorator(
              size: Size(8.w, 8.w),
              activeSize: Size(24.w, 8.w),
              color: Colors.grey.shade300,
              activeColor: AppColors.primaryElement,
              spacing: EdgeInsets.symmetric(horizontal: 4.w),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.w),
              ),
            ),
          ),
      ],
    );
  }
}

AppBar homeAppBar(WidgetRef ref) {
  var profileState = ref.watch(homeUserProfileProvider);
  return AppBar(
    title: Container(
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("PVG COET",
              style: TextStyle(color: AppColors.primaryText)),
          profileState.when(
            data: (data) {
              log("This is HERE :${data.avatar}");
              return GestureDetector(
                  child: AppBoxDecorationImage(
                imagePath: "${AppConstants.IMAGE_UPLOADS_PATH}${data.avatar}",
              ));
            },
            error: (error, stack) =>
                AppImage(width: 18.w, height: 12.h, imagePath: Img_Res.menu),
            loading: () => const CircularProgressIndicator(),
          )
        ],
      ),
    ),
  );
}

class HomeMenuBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const HomeMenuBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryElementBg2,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.all(4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onTabChanged(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedIndex == 0
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: selectedIndex == 0
                          ? [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2))
                            ]
                          : [],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    alignment: Alignment.center,
                    child: Text(
                      "Popular",
                      style: TextStyle(
                        color: selectedIndex == 0
                            ? AppColors.primaryText
                            : AppColors.primarySecondaryElementText,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => onTabChanged(1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedIndex == 1
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: selectedIndex == 1
                          ? [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2))
                            ]
                          : [],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    alignment: Alignment.center,
                    child: Text(
                      "Newest",
                      style: TextStyle(
                        color: selectedIndex == 1
                            ? AppColors.primaryText
                            : AppColors.primarySecondaryElementText,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
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
  }
}

class CourseItemGrid extends StatelessWidget {
  final WidgetRef ref;
  final AsyncValue<List<CourseItem>?> courses;
  const CourseItemGrid({super.key, required this.ref, required this.courses});

  @override
  Widget build(BuildContext context) {
    // final courseState = ref.watch(popularCoursesProvider);
    // log("Course State: $courseState");
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 6.w),
      child: courses.when(
        data: (data) {
          if (data == null) {
            return const Center(
              child: Text("No data found"),
            );
          }
          return GridView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 15.h,
                childAspectRatio: 0.75, // Adjusted ratio for better layout
              ),
              itemCount: data.length,
              itemBuilder: (_, int index) {
                return AppBoxDecorationImage(
                  imagePath:
                      "${AppConstants.IMAGE_UPLOADS_PATH}${data[index].thumbnail}",
                  courseItem: data[index],
                  func: () {
                    Navigator.of(context).pushNamed(AppRoutesName.COURSE_DETAIL,
                        arguments: {"id": data[index].id!});
                  },
                );
              });
        },
        error: (error, stackTrace) {
          return const Center(
              child: Text(
                  "Something went wrong. Please restart the app and check internet connection."));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
