import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_app/common/models/course_enties.dart';
import 'package:course_app/common/utils/app_colors.dart';
import 'package:course_app/common/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';
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
  final String imagePath;
  final BoxFit fit;
  final CourseItem? courseItem;
  final Function()? func;
  const AppBoxDecorationImage({
    super.key,
    this.height = 40,
    this.width = 40,
    this.imagePath = Img_Res.defaultImg,
    this.fit = BoxFit.fitHeight,
    this.courseItem,
    this.func,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: func,
        child: CachedNetworkImage(
          placeholder: (context, url) => Container(
            alignment: Alignment.center,
            child: const Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) => Image.asset(Img_Res.defaultImg),
          imageUrl: imagePath,
          imageBuilder: (context, imageProvider) => Container(
            height: height.h,
            width: width.h,
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: fit),
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
            ),
            child: courseItem == null
                ? Container()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: 20.w,
                        ),
                        child: FadeText(
                          text: courseItem!.name!,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.w, bottom: 30.h),
                        child: FadeText(
                          text: "${courseItem!.lesson_num!} Lessons",
                          color: AppColors.primaryFourElementText,
                          fontSize: 8.sp,
                        ),
                      )
                    ],
                  ),
          ),
        ));
  }
}

BoxDecoration networkImageDecoration({required String imagePath}) {
  return BoxDecoration(
    image: DecorationImage(
      image: NetworkImage(imagePath),
    ),
  );
}
