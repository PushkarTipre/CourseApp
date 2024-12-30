import 'dart:developer';

import 'package:course_app/common/widgets/search_widget.dart';
import 'package:course_app/global.dart';
import 'package:course_app/pages/home/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controller/home_controller.dart';
import '../provider/home_provider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({
    super.key,
  });

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late PageController controller;

  @override
  void didChangeDependencies() {
    controller =
        PageController(initialPage: ref.watch(homeScreenBannerIndexProvider));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String userToken = Global.storageService.getUserProfile().token ?? "";

    final purchasedCourses = ref.watch(purchasedCoursesProvider(userToken));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: homeAppBar(ref),
      body: RefreshIndicator(
        onRefresh: () {
          return ref.refresh(homeCourseListProvider.notifier).fetchCourseList();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    HelloText(
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    const UserName(),
                  ],
                ),

                SizedBox(
                  height: 12.h,
                ),
                purchasedCourses.when(
                  data: (courses) {
                    final courseNames =
                        courses?.map((course) => course.courseName).toList() ??
                            [];
                    final banners =
                        courses?.map((e) => e.thumbnail).toList() ?? [];
                    final courseIds =
                        courses?.map((course) => course.courseId).toList() ??
                            [];
                    log("Mapped Banners: $banners");

                    return HomeBanner(
                      courseNames:
                          courseNames, // Pass the list of course names.
                      controller: controller,
                      banners: banners,
                      courseIds: courseIds,
                    );
                  },
                  loading: () => HomeBanner(
                    courseNames: [],
                    controller: controller,
                    courseIds: [],

                    banners: [], // Placeholder for loading state.
                  ),
                  error: (error, stack) {
                    log("Error loading banners: $error");
                    return HomeBanner(
                      courseNames: [],
                      controller: controller,
                      courseIds: [],

                      banners: [], // Placeholder for error state.
                    );
                  },
                ),

                SizedBox(
                  height: 10.h,
                ),
                HelloText(
                  text: "Choose your course",
                  color: Colors.black,
                  fontSize: 20,
                ),
                const HomeMenuBar(),
                CourseItemGrid(ref: ref),
                // banner(ref: ref, controller: controller)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
