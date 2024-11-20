import 'package:course_app/common/widgets/app_bar.dart';
import 'package:course_app/pages/author_page/controller/author_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/author_widgets.dart';

class AuthorPageView extends ConsumerStatefulWidget {
  const AuthorPageView({super.key});

  @override
  ConsumerState<AuthorPageView> createState() => _AuthorPageViewState();
}

class _AuthorPageViewState extends ConsumerState<AuthorPageView> {
  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    print("This is args $args");
    //author data
    ref.watch(courseAuthorControllerProvider.notifier).init(args["token"]);
    //author course list
    ref.watch(authorCourseListControllerProvider.notifier).init(args["token"]);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var authorInfo = ref.watch(courseAuthorControllerProvider);
    var authorCourseList = ref.watch(authorCourseListControllerProvider);
    return Scaffold(
        appBar: buildGlobalAppBar(title: "Author page"),
        body: switch (authorInfo) {
          AsyncData(:final value) => value == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.black26,
                  ),
                )
              : Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
                  child: Column(
                    children: [
                      AuthorMenu(
                        authorInfo: value,
                      ),
                      AuthorDescription(
                        authorInfo: value,
                      ),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      // //go chat button
                      // AppButton(
                      //   text: "Go Chat",
                      //   onPressed: () {
                      //     print("I am tapped");
                      //   },
                      // ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AuthorCourses(authorCourseList: authorCourseList.value!),
                    ],
                  ),
                ),
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
        });
  }
}
