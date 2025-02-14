import 'dart:developer';
import 'package:course_app/common/utils/constants.dart';
import 'package:course_app/pages/mycourses/provider/mycourses_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global.dart';

class MyCourses extends ConsumerStatefulWidget {
  const MyCourses({super.key});

  @override
  ConsumerState<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends ConsumerState<MyCourses> {
  late PageController bannerController;
  int currentPage = 0;
  String userToken = Global.storageService.getUserProfile().token ?? "";

  @override
  void initState() {
    super.initState();
    bannerController = PageController(initialPage: 0);
    bannerController.addListener(() {
      int next = bannerController.page!.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final myCoursesAsync =
        ref.watch(myCoursesControllerProvider(userToken: userToken));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'My Learning',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: myCoursesAsync.when(
        data: (myCourses) {
          if (myCourses!.isEmpty) {
            return Center(child: Text('No courses found.'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(myCoursesControllerProvider);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      'Recently Purchased',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      height: 200.h,
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: bannerController,
                            itemCount: myCourses.length,
                            itemBuilder: (context, index) {
                              final course = myCourses[index];
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Stack(
                                  children: [
                                    // Course Image
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "${AppConstants.IMAGE_UPLOADS_PATH}${course.thumbnail}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    // Gradient Overlay
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.7),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Course Info
                                    Positioned(
                                      bottom: 20.h,
                                      left: 20.w,
                                      right: 20.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            course.courseName,
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          // Page Indicator
                          Positioned(
                            bottom: 10.h,
                            right: 20.w,
                            child: Row(
                              children: List.generate(
                                myCourses!.length,
                                (index) => Container(
                                  margin: EdgeInsets.only(left: 5.w),
                                  width: 8.w,
                                  height: 8.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: currentPage == index
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      'All Courses',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: myCourses?.length,
                      itemBuilder: (context, index) {
                        final course = myCourses?[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 20.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15.r),
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.all(12.w),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100.w,
                                      height: 100.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "${AppConstants.IMAGE_UPLOADS_PATH}${course?.thumbnail}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            course!.courseName,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 8.h),
                                        ],
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
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          log('Error loading courses: $error');
          return Center(child: Text('Failed to load courses.'));
        },
      ),
    );
  }

  @override
  void dispose() {
    bannerController.dispose();
    super.dispose();
  }
}
