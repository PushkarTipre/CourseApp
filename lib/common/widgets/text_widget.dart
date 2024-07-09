import 'package:course_app/common/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget text24Normal(
    {String text = '',
    Color color = AppColors.primaryText,
    FontWeight fontWeight = FontWeight.normal}) {
  return Text(
    textAlign: TextAlign.center,
    text,
    style: TextStyle(color: color, fontSize: 24, fontWeight: fontWeight),
  );
}

class Text16Normal extends StatelessWidget {
  final FontWeight weight;
  final String text;
  final Color color;
  const Text16Normal(
      {super.key,
      this.color = AppColors.primaryThreeElementText,
      this.text = '',
      this.weight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text,
      style: TextStyle(color: color, fontSize: 16, fontWeight: weight),
    );
  }
}

class Text14Normal extends StatelessWidget {
  final String text;
  final Color color;
  const Text14Normal(
      {super.key,
      this.text = '',
      this.color = AppColors.primaryThreeElementText});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text,
      style:
          TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.normal),
    );
  }
}

class Text10Normal extends StatelessWidget {
  final String text;
  final Color color;
  const Text10Normal(
      {super.key,
      this.text = '',
      this.color = AppColors.primaryThreeElementText});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text,
      style:
          TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.normal),
    );
  }
}

class Text11Normal extends StatelessWidget {
  final String text;
  final Color color;
  const Text11Normal(
      {super.key, this.text = '', this.color = AppColors.primaryElementText});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text,
      style:
          TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.normal),
    );
  }
}

Widget textUnderline({String text = 'Your Text'}) {
  return GestureDetector(
    onTap: () {},
    child: Text(
      text,
      style: TextStyle(
          color: AppColors.primaryText,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.primaryText,
          fontWeight: FontWeight.normal,
          fontSize: 12.sp),
    ),
  );
}
