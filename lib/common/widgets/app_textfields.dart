import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import 'image_widgets.dart';

class AppTextFields extends StatelessWidget {
  const AppTextFields({
    super.key,
    this.controller,
    this.text = '',
    this.iconName = '',
    this.hintText = 'Enter your info',
    this.obscureText = false,
    this.func,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final String text;
  final String iconName;
  final String hintText;
  final bool obscureText;
  final void Function(String value)? func;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25.w, right: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryThreeElementText,
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: 325.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(
                color: AppColors.primaryFourElementText.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 17.w),
                  child: AppImage(
                    imagePath: iconName,
                    width: 20.w,
                    height: 20.h,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: AppTextFieldOnly(
                    controller: controller,
                    hintText: hintText,
                    func: func,
                    obscureText: obscureText,
                  ),
                ),
                if (suffixIcon != null) suffixIcon!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration appBoxDecorationTextField({
  Color color = Colors.white,
  Color borderColor = Colors.transparent,
  double radius = 16,
}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius.r),
    border: Border.all(color: borderColor.withOpacity(0.3)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 12,
        spreadRadius: 1,
        offset: const Offset(0, 3),
      ),
    ],
  );
}

class AppTextFieldOnly extends StatelessWidget {
  const AppTextFieldOnly({
    super.key,
    this.hintText = '',
    this.width = 280,
    this.height = 50,
    this.controller,
    this.search = false,
    this.func,
    this.obscureText = false,
  });

  final String hintText;
  final double width;
  final double height;
  final bool? search;
  final TextEditingController? controller;
  final void Function(String value)? func;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: TextField(
        controller: controller,
        onChanged: search == false ? (value) => func!(value) : null,
        onSubmitted: search == true ? (value) => func!(value) : null,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.multiline,
        style: TextStyle(
          fontSize: 14.sp,
          color: AppColors.primaryText,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 5.h, left: 10.w),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: AppColors.primaryThreeElementText.withOpacity(0.5),
            fontWeight: FontWeight.w400,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        maxLines: 1,
        autocorrect: false,
        obscureText: obscureText,
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    this.controller,
    this.hintText = 'Search...',
    this.onSubmitted,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String hintText;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 17.w),
            child: Icon(
              Icons.search,
              size: 20.sp,
              color: AppColors.primaryThreeElementText,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              textInputAction: TextInputAction.search,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.primaryText,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.primaryThreeElementText.withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 5.h, left: 10.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
