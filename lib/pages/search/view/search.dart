import 'package:course_app/common/models/course_enties.dart';
import 'package:course_app/common/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/routes/app_routes_name.dart';
import '../../../common/utils/app_colors.dart';
import '../../../common/utils/constants.dart';
import '../../../common/widgets/search_widget.dart';
import '../../../common/widgets/text_widget.dart';
import '../../home/widgets/home_widget.dart';
import '../controller/courses_search_controller.dart';
import '../widget/courses_search_widget.dart';

class Search extends ConsumerWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchProvider = ref.watch(coursesSearchControllerProvider);
    return Scaffold(
      appBar: buildGlobalAppBar(title: "Search Courses"),
      body: RefreshIndicator(
        onRefresh: () {
          return ref
              .watch(coursesSearchControllerProvider.notifier)
              .reloadSearchData();
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
                AppSearchBar(
                  searchFunc: (search) {
                    ref
                        .watch(coursesSearchControllerProvider.notifier)
                        .searchData(search);
                  },
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: switch (searchProvider) {
                    AsyncData(:final value) => value!.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : CoursesSearchWidget(value: value),
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
                )

                // banner(ref: ref, controller: controller)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
