import 'package:course_app/common/utils/app_colors.dart';
import 'package:course_app/common/utils/img_res.dart';
import 'package:course_app/common/widgets/image_widgets.dart';
import 'package:course_app/common/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCourses extends StatelessWidget {
  const ProfileCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProfileLink(
            imgPath: Img_Res.profileVideo,
            text: "My Coursees",
          ),
          ProfileLink(
            imgPath: Img_Res.profileBook,
            text: "Buy Coursees",
          ),
          ProfileLink(
            imgPath: Img_Res.profileStar,
            text: "4.9",
          )
        ],
      ),
    );
  }
}

class ProfileLink extends StatelessWidget {
  final String imgPath;
  final String text;
  const ProfileLink({super.key, required this.imgPath, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                blurRadius: 3),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImage(
              width: 20.w,
              height: 20.h,
              imagePath: imgPath,
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text11Normal(
                text: text,
                weight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
