import 'package:course_app/common/utils/app_colors.dart';
import 'package:course_app/common/utils/img_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appImage(
    {String iconPath = Img_Res.defaultImg,
    double width = 16,
    double height = 16}) {
  return Image.asset(
    iconPath.isEmpty ? Img_Res.defaultImg : iconPath,
    width: width.w,
    height: height.h,
  );
}

Widget appImageWithColour(
    {String iconPath = Img_Res.defaultImg,
    double width = 16,
    double height = 16,
    Color color = AppColors.primaryElement}) {
  return Image.asset(
    iconPath.isEmpty ? Img_Res.defaultImg : iconPath,
    width: width.w,
    height: height.h,
    color: color,
  );
}
