import 'package:course_app/common/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/course_enties.dart';
import '../routes/app_routes_name.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.value});
  final List<CourseItem> value;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final val in value)
          Container(
            width: 325.w,
            height: 80.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            margin: EdgeInsets.only(bottom: 15.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                color: const Color.fromRGBO(255, 255, 255, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  )
                ]),
            child: InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                  AppRoutesName.COURSE_DETAIL,
                  arguments: {"id": val.id}),
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
                                    "${AppConstants.IMAGE_UPLOADS_PATH}${val.thumbnail}"))),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 6.w),
                            width: 180.w,
                            child: Text13Normal(
                              maxLines: 1,
                              color: AppColors.primaryText,
                              weight: FontWeight.bold,
                              text: val.name.toString(),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 6.w),
                            width: 180.w,
                            child: Text10Normal(
                              color: AppColors.primaryText,
                              text: "${val.lesson_num} lessons",
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: 55.w,
                    child: Text13Normal(
                      text: "₹${val.price}",
                    ),
                  )
                ],
              ),
            ),
          )
      ],
    );
  }
}
