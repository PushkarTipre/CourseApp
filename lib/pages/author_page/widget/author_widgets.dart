import 'package:course_app/common/models/course_enties.dart';
import 'package:course_app/common/utils/constants.dart';
import 'package:course_app/common/utils/img_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/app_colors.dart';

class AuthorMenu extends StatelessWidget {
  const AuthorMenu({super.key, required this.authorInfo});
  final AuthorItem authorInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340.w,
      height: 210.h,
      child: Stack(
        children: [
          // Background Image
          Container(
            width: 340.w,
            height: 160.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(Img_Res.background),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  spreadRadius: 1,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
          ),
          // Author Card
          Positioned(
            bottom: 0,
            left: 20.w,
            right: 20.w,
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Author Avatar
                  Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.network(
                        "${AppConstants.IMAGE_UPLOADS_PATH}${authorInfo.avatar}",
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.primaryElement.withOpacity(0.2),
                          child: Icon(
                            Icons.person,
                            color: AppColors.primaryElement,
                            size: 40.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  // Author Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          authorInfo.name ?? "Author",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryText,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          authorInfo.job ?? "Professional",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryThreeElementText,
                            letterSpacing: 0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10.h),

                        // Row(
                        //   children: [
                        //     _buildStatItem(Img_Res.people, "10", true),
                        //     _buildStatItem(Img_Res.star, "90", false),
                        //     _buildStatItem(Img_Res.downloadDetail, "12", false),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class AuthorDescription extends StatelessWidget {
//   const AuthorDescription({super.key, required this.authorInfo});
//   final AuthorItem authorInfo;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 340.w,
//       margin: EdgeInsets.only(top: 20.h),
//       padding: EdgeInsets.all(16.r),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 12,
//             spreadRadius: 1,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 height: 20.h,
//                 width: 4.w,
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryElement,
//                   borderRadius: BorderRadius.circular(2.r),
//                 ),
//               ),
//               // SizedBox(width: 8.w),
//               // Text(
//               //   "About Me",
//               //   style: TextStyle(
//               //     fontSize: 18.sp,
//               //     fontWeight: FontWeight.w800,
//               //     color: AppColors.primaryText,
//               //     letterSpacing: 0.3,
//               //   ),
//               // ),
//             ],
//           ),
//           // SizedBox(height: 12.h),
//           // Text(
//           //   authorInfo.description ?? "No description available",
//           //   style: TextStyle(
//           //     fontSize: 14.sp,
//           //     height: 1.5,
//           //     color: AppColors.primaryThreeElementText,
//           //     letterSpacing: 0.2,
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }

class AuthorCourses extends StatelessWidget {
  final List<CourseItem> authorCourseList;

  const AuthorCourses({
    super.key,
    required this.authorCourseList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h, bottom: 25.h),
      width: 340.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (authorCourseList.isNotEmpty) ...[
            Row(
              children: [
                Container(
                  height: 22.h,
                  width: 5.w,
                  decoration: BoxDecoration(
                    color: AppColors.primaryElement,
                    borderRadius: BorderRadius.circular(2.5.r),
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "Author Courses",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryText,
                    letterSpacing: 0.3,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryElement.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    "${authorCourseList.length} Courses",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryElement,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],

          if (authorCourseList.isEmpty)
            Container(
              width: 340.w,
              height: 180.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 15,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.book_outlined,
                      size: 36.sp,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    "No courses available",
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "Author hasn't published any courses yet",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),

          // Course List with improved styling
          if (authorCourseList.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: authorCourseList.length,
              itemBuilder: (_, index) {
                final course = authorCourseList[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 15.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18.r),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18.r),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          "/course_detail",
                          arguments: {"id": course.id},
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(14.r),
                        child: Row(
                          children: [
                            // Course Thumbnail
                            Container(
                              height: 80.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14.r),
                                child: Image.network(
                                  "${AppConstants.IMAGE_UPLOADS_PATH}${course.thumbnail}",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    color: Colors.grey.shade200,
                                    child: Icon(
                                      Icons.book,
                                      color: AppColors.primaryElement,
                                      size: 32.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),

                            // Course details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course.name ?? "No Name Available",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryText,
                                      height: 1.3,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryElement
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        child: Text(
                                          "${course.lesson_num} Lessons",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryElement,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      if (course.is_free == 1)
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.w,
                                            vertical: 4.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade100,
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                          ),
                                          child: Text(
                                            "Free",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.green.shade700,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Right arrow
                            Container(
                              width: 36.w,
                              height: 36.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 14.sp,
                                color: Colors.grey.shade600,
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
    );
  }
}
