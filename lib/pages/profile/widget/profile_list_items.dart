import 'package:course_app/common/routes/app_routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/app_colors.dart';
import '../../../common/utils/img_res.dart';
import '../../../common/widgets/image_widgets.dart';
import '../../../common/widgets/text_widget.dart';

class ProfileListItems extends StatelessWidget {
  const ProfileListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListItem(
              imagePath: Img_Res.settings,
              text: "Settings",
              func: () =>
                  Navigator.of(context).pushNamed(AppRoutesName.SETTINGS)),
          // ListItem(imagePath: Img_Res.creditCard, text: "Payment detail"),
          // ListItem(imagePath: Img_Res.award, text: "Achievement"),
          // ListItem(imagePath: Img_Res.love, text: "Love"),
          // ListItem(imagePath: Img_Res.reminder, text: "Reminder")
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback? func;
  const ListItem(
      {super.key, required this.imagePath, required this.text, this.func});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            padding: EdgeInsets.all(7.w),
            margin: EdgeInsets.only(bottom: 15.h),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primaryElement),
            ),
            child: AppImage(
              imagePath: imagePath,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.w, bottom: 15.h),
            child: Text13Normal(
              align: TextAlign.center,
              text: text,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
