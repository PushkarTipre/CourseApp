import 'package:course_app/common/widgets/text_widget.dart';
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
  });

  final TextEditingController? controller;
  final String text;
  final String iconName;
  final String hintText;
  final bool obscureText;
  final void Function(String value)? func;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25.w, right: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text14Normal(text: text),
          SizedBox(
            height: 5.h,
          ),
          Container(
            width: 325.w,
            height: 50.h,
            //color: Colors.red,
            decoration: appBoxDecorationTextField(),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 17.w),
                  child: AppImage(imagePath: iconName),
                ),
                AppTextFieldOnly(
                    controller: controller,
                    hintText: hintText,
                    func: func,
                    obscureText: obscureText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration appBoxDecorationTextField({
  Color color = AppColors.primaryBackground,
  Color borderColor = AppColors.primaryFourElementText,
  double radius = 15,
}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor));
}

class AppTextFieldOnly extends StatelessWidget {
  const AppTextFieldOnly(
      {super.key,
      this.hintText = '',
      this.width = 280,
      this.height = 50,
      this.controller,
      this.search = false,
      this.func,
      this.obscureText = false});
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
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 5.h, left: 10.w),
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
        ),
        maxLines: 1,
        autocorrect: false,
        obscureText: obscureText,
      ),
    );
  }
}
