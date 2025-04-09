import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_app/common/models/course_enties.dart';
import 'package:course_app/common/utils/app_colors.dart';
import 'package:course_app/common/widgets/text_widget.dart';
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
            offset: const Offset(0, 1)),
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
            offset: const Offset(0, 1)),
      ]);
}

class AppBoxDecorationImage extends StatelessWidget {
  final double width;
  final double height;
  final String imagePath;
  final BoxFit fit;
  final CourseItem? courseItem;
  final Function()? func;

  const AppBoxDecorationImage({
    super.key,
    this.height = 40,
    this.width = 40,
    this.imagePath = Img_Res.defaultImg,
    this.fit = BoxFit.fitWidth,
    this.courseItem,
    this.func,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        height: height.h,
        width: width.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    alignment: Alignment.center,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) =>
                      Image.asset(Img_Res.defaultImg, fit: BoxFit.cover),
                  imageUrl: imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            if (courseItem != null)
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        // Wrap FadeText in Flexible
                        child: FadeText(
                          text: courseItem!.name!,
                          fontSize: 14.sp,
                          color: AppColors.primarySecondaryElementText,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Flexible(
                        // Wrap FadeText in Flexible
                        child: FadeText(
                          text: "${courseItem!.lesson_num!} Lessons" ?? "",
                          color: AppColors.primaryThreeElementText,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

BoxDecoration networkImageDecoration({required String imagePath}) {
  return BoxDecoration(
    image: DecorationImage(
      image: NetworkImage(imagePath),
    ),
  );
}
