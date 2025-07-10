import 'package:course_app/common/widgets/app_bar.dart';

import 'package:course_app/pages/course_details/controller/course_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/course_detail_widgets.dart';

class CourseDetail extends ConsumerStatefulWidget {
  const CourseDetail({super.key});

  @override
  ConsumerState<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends ConsumerState<CourseDetail> {
  late var args;

  @override
  void didChangeDependencies() {
    var id = ModalRoute.of(context)!.settings.arguments as Map;
    args = id["id"];

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var courseData =
        ref.watch(courseDetailControllerProvider(index: args.toInt()));
    var lessondata =
        ref.watch(courseLessonListControllerProvider(index: args.toInt()));
    // var lessonData = ref.watch(lessonDataControllerProvider);

    return Scaffold(
      appBar: buildGlobalAppBar(title: "Course Detail"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // lessonData.when(data: (data)=>Container(), error: (error), loading: loading)
              courseData.when(
                  data: (courseDataValue) => courseDataValue == null
                      ? const SizedBox()
                      : Column(
                          children: [
                            CourseDetailThumbnail(courseItem: courseDataValue),
                            CourseDetailIconText(courseItem: courseDataValue),
                            CourseDetailDescription(
                                courseItem: courseDataValue),
                            CourseDetailGoBuyButton(
                              courseItem: courseDataValue,
                            ),
                            CourseDetailIncludes(
                              courseItem: courseDataValue,
                            ),
                            lessondata.when(
                              data: (lessonDataValue) => lessonDataValue == null
                                  ? const SizedBox()
                                  : LessonInfo(
                                      lessonData: lessonDataValue,
                                      ref: ref,
                                      courseId: args,
                                      courseItem:
                                          courseDataValue, // Now we can safely pass the courseItem
                                    ),
                              error: (error, stackTrace) =>
                                  const Text("Error loading lesson data"),
                              loading: () => SizedBox(
                                height: 200
                                    .h, // Reduced height since it's in a Column
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 15.h),
                              child: FeedbackButton(
                                courseItem: courseDataValue,
                                completionPercentage: 85,
                                requiredPercentage: 0,
                              ),
                            ),
                          ],
                        ),
                  error: (error, stackTrace) =>
                      const Text("Error loading course data"),
                  loading: () => SizedBox(
                        height: 500.h,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
