import 'package:course_app/common/utils/app_colors.dart';
import 'package:course_app/common/widgets/app_shadows.dart';
import 'package:course_app/common/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double width;
  final double height;
  final bool isLogin;
  const AppButton({
    super.key,
    this.text = "",
    this.onPressed,
    this.width = 325,
    this.height = 50,
    this.isLogin = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: appBoxShadow(
          boxBorder: Border.all(color: AppColors.primaryFourElementText),
          color: isLogin ? AppColors.primaryElement : Colors.white,
        ),
        child: Center(
            child: Text16Normal(
                text: text,
                color: isLogin
                    ? AppColors.primaryBackground
                    : AppColors.primaryElement)),
      ),
    );
  }
}
