import 'package:course_app/common/widgets/search_widget.dart';
import 'package:course_app/pages/home/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controller/home_controller.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late PageController controller;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    controller =
        PageController(initialPage: ref.watch(homeScreenBannerIndexProvider));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                const HelloText(),
                const UserName(),
                SizedBox(
                  height: 20.h,
                ),
                AppSearchBar(
                  searchFunc: (value) => print("Homepage"),
                ),
                SizedBox(
                  height: 20.h,
                ),
                HomeBanner(controller: controller, ref: ref),
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
