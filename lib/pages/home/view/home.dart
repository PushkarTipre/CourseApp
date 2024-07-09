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
      appBar: homeAppBar(),
      body: Padding(
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
              searchBar(),
              SizedBox(
                height: 20.h,
              ),
              HomeBanner(controller: controller, ref: ref),
              const HomeMenuBar(),
              const CourseItemGrid(),
              // banner(ref: ref, controller: controller)
            ],
          ),
        ),
      ),
    );
  }
}
