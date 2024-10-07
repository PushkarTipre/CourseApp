import 'package:course_app/common/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controller/courses_bought_controller.dart';
import '../widget/courses_bought_widget.dart';

class CoursesBought extends ConsumerWidget {
  const CoursesBought({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesList = ref.watch(coursesBoughtControllerProvider);
    return Scaffold(
      appBar: buildGlobalAppBar(title: "My Courses"),
      body: switch (coursesList) {
        AsyncData(:final value) => value == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : CoursesBoughtWidgets(value: value),
        AsyncError(:final error) => Text('Error $error'),
        _ => Center(
            child: SizedBox(
              height: 20.h,
              width: 20.h,
              child: CircularProgressIndicator(
                color: Colors.black26,
                strokeWidth: 2.r,
              ),
            ),
          ),
      },
    );
  }
}
