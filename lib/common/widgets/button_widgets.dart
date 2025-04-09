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
  final bool isOutlined;

  const AppButton({
    super.key,
    this.text = "",
    this.onPressed,
    this.width = 325,
    this.height = 50,
    this.isLogin = true,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          color: isLogin ? AppColors.primaryElement : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: isOutlined
              ? Border.all(
                  color: AppColors.primaryElement.withOpacity(0.3),
                  width: 1.5,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: isLogin
                  ? AppColors.primaryElement.withOpacity(0.2)
                  : Colors.black.withOpacity(0.08),
              blurRadius: 15,
              spreadRadius: 1,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: isLogin ? Colors.white : AppColors.primaryElement,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
