import 'dart:developer';

import 'package:course_app/common/models/course_enties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/routes/app_routes_name.dart';
import '../../../common/utils/app_colors.dart';
import '../../../common/utils/constants.dart';
import '../controller/category_course_controller.dart';

class CourseListScreen extends ConsumerStatefulWidget {
  const CourseListScreen({super.key});

  @override
  ConsumerState<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends ConsumerState<CourseListScreen> {
  int? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    void clearCategory() {
      setState(() {
        selectedCategoryId = null;
      });
    }

    final coursesAsyncValue = ref.watch(
        categoryCourseControllerProvider(categoryId: selectedCategoryId));

    final courseCategoriesAsyncValue =
        ref.watch(courseCategoryControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore Courses"),
        backgroundColor: AppColors.primaryElement,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.search, color: Colors.white),
        //     onPressed: () {},
        //     tooltip: 'Search Courses',
        //   ),
        //   IconButton(
        //     icon: const Icon(Icons.filter_list, color: Colors.white),
        //     onPressed: () {},
        //     tooltip: 'Filter Courses',
        //   ),
        // ],
      ),
      // Pull-to-Refresh Body (simulated)
      body: RefreshIndicator(
        color: AppColors.primaryElement,
        onRefresh: () async {
          clearCategory();
          ref.invalidate(courseCategoryControllerProvider);
          ref.invalidate(
              categoryCourseControllerProvider(categoryId: selectedCategoryId));
        },
        child: Column(
          children: [
            // Category Chips
            courseCategoriesAsyncValue.when(
              data: (categories) {
                if (categories == null || categories.isEmpty) {
                  return SizedBox(
                    height: 60.h,
                    child: const Center(child: Text('No categories found')),
                  );
                }

                return Container(
                  height: 60.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((category) {
                        final isSelected = selectedCategoryId == category.id;
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: ChoiceChip(
                              checkmarkColor: Colors.white,
                              label: Text(category.title ?? 'Unnamed Category'),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  if (isSelected) {
                                    selectedCategoryId = null;
                                  } else {
                                    selectedCategoryId = category.id;
                                  }
                                });
                              },
                              selectedColor: AppColors.primaryElement,
                              backgroundColor: Colors.grey.shade100,
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.primaryText,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              elevation: isSelected ? 4 : 0,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
              loading: () => SizedBox(
                height: 60.h,
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(AppColors.primaryElement),
                  ),
                ),
              ),
              error: (error, stackTrace) => SizedBox(
                height: 60.h,
                child: Center(
                  child: Text(
                    'Error loading categories',
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: coursesAsyncValue.when(
                data: (courses) {
                  if (courses == null || courses.isEmpty) {
                    return Center(
                      child: Text(
                        'No courses found.',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.primaryText,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return CourseListItem(course: courses[index]);
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(AppColors.primaryElement),
                  ),
                ),
                error: (error, stackTrace) => Center(
                  child: Text(
                    'Error occurred while fetching courses.',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseListItem extends StatelessWidget {
  final CourseItem course;
  const CourseListItem({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    log("Course Name: ${course.id}");

    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              spreadRadius: 1,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutesName.COURSE_DETAIL,
                  arguments: {"id": course.id});
            },
            child: Padding(
              padding: EdgeInsets.all(12.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      "${AppConstants.IMAGE_UPLOADS_PATH}${course.thumbnail}",
                      width: 100.w,
                      height: 100.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 100.w,
                        height: 100.h,
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.primaryElement,
                          size: 30.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.name ?? "",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "${course.lesson_num} Lessons • ${course.lesson_num}h ",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.primaryThreeElementText,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Description: ${course.description}",
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 12.sp,
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.primaryThreeElementText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
