import 'package:course_app/common/utils/app_colors.dart';
import 'package:course_app/common/utils/img_res.dart';
import 'package:course_app/common/widgets/app_shadows.dart';
import 'package:course_app/common/widgets/app_textfields.dart';
import 'package:course_app/common/widgets/image_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget searchBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //crossAxisAlignment: CrossAxisAlignment.baseline,
    children: [
      Container(
        width: 280.w,
        height: 40.h,
        decoration: appBoxShadow(
            color: AppColors.primaryBackground,
            boxBorder: Border.all(color: AppColors.primaryFourElementText)),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 17.w),
              child: const AppImage(imagePath: Img_Res.searchIcon),
            ),
            Container(
              width: 240.w,
              height: 40.h,
              child: appTextFieldOnly(
                  width: 240.w, height: 40.h, hintText: 'Search your course'),
            )
          ],
        ),
      ),
      GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(5.w),
          height: 40.h,
          width: 40.w,
          decoration: appBoxShadow(
            boxBorder: Border.all(color: AppColors.primaryElement),
          ),
          child: const AppImage(imagePath: Img_Res.searchButton),
        ),
      )
    ],
  );
}
