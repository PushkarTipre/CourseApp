import 'package:course_app/common/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/img_res.dart';

BoxDecoration appBoxShadow({
  Color color = AppColors.primaryElement,
  double radius = 15,
  double sR = 1,
  double bR = 2,
  BoxBorder? boxBorder,
}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: boxBorder,
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: sR,
            blurRadius: bR,
            offset: Offset(0, 1)),
      ]);
}

BoxDecoration appBoxShadowWithRadius(
    {Color color = AppColors.primaryElement,
    double radius = 15,
    double sR = 1,
    double bR = 2,
    BoxBorder? border}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.h),
          topRight: Radius.circular(20.h),
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius)),
      border: border,
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: sR,
            blurRadius: bR,
            offset: Offset(0, 1)),
      ]);
}

class AppBoxDecorationImage extends StatelessWidget {
  final double width;
  final double height;
  final String imaegePath;
  const AppBoxDecorationImage(
      {super.key,
      this.height = 40,
      this.width = 40,
      this.imaegePath = Img_Res.defaultImg});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.h,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imaegePath), fit: BoxFit.fitHeight),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
    );
  }
}
