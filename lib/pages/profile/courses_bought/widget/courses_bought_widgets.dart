import 'package:course_app/common/routes/app_routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';

import '../../../../common/models/course_enties.dart';
import '../../../../common/utils/app_colors.dart';
import '../../../../common/utils/constants.dart';
import '../../../../common/widgets/text_widget.dart';

class CoursesBoughtWidgets extends ConsumerWidget {
  final List<CourseItem> value;
  const CoursesBoughtWidgets({super.key, required this.value});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (value.isEmpty) {
      return const Center(
        child: Text16Normal(
          text: "You have not bought any courses yet",
          color: AppColors.primaryThreeElementText,
          weight: FontWeight.bold,
        ),
      );
    }
    return ListView.builder(
        itemCount: value.length,
        itemBuilder: (_, index) {
          return Container(
            width: 325.w,
            height: 80.h,
            margin: EdgeInsets.only(bottom: 15.h),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                color: const Color.fromRGBO(255, 255, 255, 1),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 1))
                ]),
            child: InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                  AppRoutesName.COURSE_DETAIL,
                  arguments: {"id": value.elementAt(index).id}),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 60.h,
                        width: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: NetworkImage(
                                    "${AppConstants.IMAGE_UPLOADS_PATH}${value.elementAt(index).thumbnail}"))),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 6.w),
                            width: 180.w,
                            child: Text13Normal(
                              maxLines: 1,
                              color: AppColors.primaryText,
                              weight: FontWeight.bold,
                              text: value.elementAt(index).name.toString(),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 6.w),
                            width: 180.w,
                            child: Text10Normal(
                              color: AppColors.primaryThreeElementText,
                              text:
                                  "${value.elementAt(index).lesson_num} Lesson",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: 55.w,
                    child: Text13Normal(
                      text: "\$${value.elementAt(index).price}",
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
