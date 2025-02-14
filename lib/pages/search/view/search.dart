import 'package:course_app/common/utils/pop_messages.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/search_widget.dart';

import '../controller/courses_search_controller.dart';
import '../widget/courses_search_widget.dart';

class Search extends ConsumerWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchProvider = ref.watch(coursesSearchControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Search Courses",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return ref
              .watch(coursesSearchControllerProvider.notifier)
              .reloadSearchData();
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    // Enhanced search bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: AppSearchBar(
                        searchFunc: (search) {
                          if (search.trim().isEmpty) {
                            toastInfo("Please enter a search term");
                            return;
                          }
                          ref
                              .watch(coursesSearchControllerProvider.notifier)
                              .searchData(search);
                        },
                      ),
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: switch (searchProvider) {
                  AsyncData(:final value) => value!.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off_rounded,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                "No courses found",
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "Try searching with different keywords",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        )
                      : CoursesSearchWidget(value: value),
                  AsyncError() => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: 64,
                            color: theme.colorScheme.error,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Something went wrong',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.error,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  _ => Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.r,
                      ),
                    ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
