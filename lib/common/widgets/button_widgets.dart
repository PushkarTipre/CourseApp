import 'package:course_app/common/utils/app_colors.dart';
import 'package:course_app/common/widgets/app_shadows.dart';
import 'package:course_app/common/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appButton(
    {String text = '',
    void Function()? onPressed,
    double width = 325,
    double height = 50,
    bool isLogin = true}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: width.w,
      height: height.h,
      child: Center(
          child: Text16Normal(
              text: text,
              color: isLogin
                  ? AppColors.primaryBackground
                  : AppColors.primaryElement)),
      decoration: appBoxShadow(
        boxBorder: Border.all(color: AppColors.primaryFourElementText),
        color: isLogin ? AppColors.primaryElement : Colors.white,
      ),
    ),
  );
}
