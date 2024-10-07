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
  final TextAlign align;
  const Text16Normal({
    super.key,
    this.color = AppColors.primaryThreeElementText,
    this.text = '',
    this.weight = FontWeight.normal,
    this.align = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: align,
      text,
      style: TextStyle(color: color, fontSize: 16, fontWeight: weight),
    );
  }
}

class Text14Normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight weight;
  const Text14Normal(
      {super.key,
      this.text = '',
      this.color = AppColors.primaryThreeElementText,
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
      maxLines: 1,
      text,
      style: TextStyle(
        color: color,
        fontSize: 10,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class Text9Normal extends StatelessWidget {
  final String text;
  final Color color;
  const Text9Normal(
      {super.key,
      this.text = '',
      this.color = AppColors.primaryThreeElementText});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text,
      style: TextStyle(
        color: color,
        fontSize: 9.sp,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class FadeText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  const FadeText({
    super.key,
    this.fontSize = 10,
    this.text = '',
    this.color = AppColors.primaryThreeElementText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.fade,
      softWrap: false,
      text,
      style: TextStyle(
          color: color, fontSize: fontSize.sp, fontWeight: FontWeight.bold),
    );
  }
}

class Text11Normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight weight;
  const Text11Normal(
      {super.key,
      this.text = '',
      this.color = AppColors.primaryElementText,
      this.weight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text,
      style: TextStyle(color: color, fontSize: 10, fontWeight: weight),
    );
  }
}

class Text13Normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight weight;
  final TextAlign align;
  final int? maxLines;
  const Text13Normal({
    super.key,
    this.text = '',
    this.color = AppColors.primaryElementText,
    this.weight = FontWeight.bold,
    this.align = TextAlign.start,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      // textAlign: TextAlign.start,
      maxLines: maxLines,
      textAlign: align,
      text,
      style: TextStyle(
        color: color,
        fontSize: 13.sp,
        fontWeight: weight,
      ),
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
