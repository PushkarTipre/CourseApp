import 'package:course_app/common/routes/app_routes_name.dart';
import 'package:course_app/common/utils/img_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/app_colors.dart';
import '../../../common/widgets/image_widgets.dart';
import '../../../common/widgets/text_widget.dart';

class ProfileCourses extends StatelessWidget {
  const ProfileCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const ProfileLink(
          //   imagePath: Img_Res.profileVideo,
          //   text: "My Courses",
          // ),
          ProfileLink(
            imagePath: Img_Res.profileBook,
            text: "Courses Bought",
            func: () =>
                Navigator.of(context).pushNamed(AppRoutesName.COURSES_BOUGHT),
          ),
          // const ProfileLink(
          //   imagePath: Img_Res.profileStar,
          //   text: "4.9",
          // ),
        ],
      ),
    );
  }
}

class ProfileLink extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback? func;
  const ProfileLink(
      {super.key, required this.imagePath, required this.text, this.func});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.h),
        width: 100.w,
        decoration: BoxDecoration(
            color: AppColors.primaryElement,
            borderRadius: BorderRadius.circular(15.w),
            border: Border.all(color: AppColors.primaryElement),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 3)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImage(
              width: 20.w,
              height: 20.h,
              imagePath: imagePath,
            ),
            Container(
                margin: EdgeInsets.only(top: 5.h),
                child: Text11Normal(
                  text: text,
                  weight: FontWeight.bold,
                ))
          ],
        ),
      ),
    );
  }
}
