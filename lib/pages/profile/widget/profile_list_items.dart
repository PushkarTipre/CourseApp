import 'package:course_app/common/routes/app_routes_name.dart';
import 'package:course_app/common/utils/app_colors.dart';
import 'package:course_app/common/utils/img_res.dart';
import 'package:course_app/common/widgets/image_widgets.dart';
import 'package:course_app/common/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileListItems extends StatelessWidget {
  const ProfileListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
      child: Column(
        children: [
          ListItems(
              path: Img_Res.settings,
              text: "Settings",
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutesName.SETTINGS);
              }),
          ListItems(path: Img_Res.creditCard, text: "Payment details"),
          ListItems(path: Img_Res.award, text: "Achievements "),
          ListItems(path: Img_Res.love, text: "Love"),
          ListItems(path: Img_Res.reminder, text: "Settings"),
        ],
      ),
    );
  }
}

class ListItems extends StatelessWidget {
  final String path;
  final String text;
  final VoidCallback? onTap;
  const ListItems(
      {super.key, required this.path, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(7.w),
            margin: EdgeInsets.only(bottom: 15.h),
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: AppColors.primaryElement,
              ),
            ),
            child: AppImage(imagePath: path),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.w, bottom: 15.h),
            child: Text13Normal(
              text: text,
              align: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
