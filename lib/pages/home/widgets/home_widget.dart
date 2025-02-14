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

import '../../../global.dart';
import '../provider/home_provider.dart';

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
          SizedBox(
            height: 290.h,
            child: PageView.builder(
              controller: controller,
              itemCount: banners.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.r),
                        ),
                        child: Image.network(
                          "${AppConstants.IMAGE_UPLOADS_PATH}${banners[index]}",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 150.h,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                courseNames[index],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        AppRoutesName.COURSE_DETAIL,
                                        arguments: {"id": courseIds[index]});
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade200,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text("Continue"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        else
          const Text(
            "Please purchase or apply for courses to get started.",
            style: TextStyle(color: Colors.grey),
          ),
        SizedBox(height: 5.h),
        if (hasBanners)
          DotsIndicator(
            dotsCount: banners.length,
            position: homeScreenBannerIndex,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(24, 8),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.w),
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

class HomeMenuBar extends StatefulWidget {
  const HomeMenuBar({super.key});

  @override
  _HomeMenuBarState createState() => _HomeMenuBarState();
}

class _HomeMenuBarState extends State<HomeMenuBar> {
  int selectedIndex = 0; // Track the selected tab index

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
                  onTap: () => setState(() {
                    selectedIndex = 0;
                  }),
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
                                offset: const Offset(0, 2),
                              ),
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
              SizedBox(width: 8.w), // Spacing between tabs
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    selectedIndex = 1;
                  }),
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
                                offset: const Offset(0, 2),
                              ),
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
  const CourseItemGrid({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    final courseState = ref.watch(homeCourseListProvider);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 6.w),
      child: courseState.when(
        data: (data) => GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 15.h,
              childAspectRatio: 0.75, // Adjusted ratio for better layout
            ),
            itemCount: data?.length,
            itemBuilder: (_, int index) {
              return AppBoxDecorationImage(
                imagePath:
                    "${AppConstants.IMAGE_UPLOADS_PATH}${data?[index].thumbnail}",
                courseItem: data![index],
                func: () {
                  Navigator.of(context).pushNamed(AppRoutesName.COURSE_DETAIL,
                      arguments: {"id": data[index].id!});
                },
              );
            }),
        error: (error, stackTrace) {
          print(stackTrace.toString());
          return const Center(
              child: Text(
                  "Something went wrong. Please restart the app and check internet connection."));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
