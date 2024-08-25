import 'package:course_app/common/models/lesson_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/app_colors.dart';
import '../../../common/utils/constants.dart';
import '../../../common/utils/img_res.dart';
import '../../../common/widgets/app_shadows.dart';
import '../../../common/widgets/image_widgets.dart';
import '../../../common/widgets/text_widget.dart';
import '../controller/lesson_controller.dart';

class LessonVideos extends StatelessWidget {
  final List<LessonVideoItem> lessonData;
  final WidgetRef ref;
  final Function? syncVidIndex;
  const LessonVideos(
      {super.key,
      required this.lessonData,
      required this.ref,
      required this.syncVidIndex});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lessonData.length,
      itemBuilder: (_, index) {
        return Container(
          margin: EdgeInsets.only(top: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          width: 325.w,
          height: 80.h,
          decoration: appBoxShadow(
            radius: 10.w,
            color: Color.fromRGBO(255, 255, 255, 1),
            bR: 3,
            sR: 2,
          ),
          child: InkWell(
            onTap: () {
              var vidUrl = lessonData[index].url;
              ref
                  .read(lessonDataControllerProvider.notifier)
                  .playNextVid(vidUrl!);
            },
            child: Row(
              children: [
                AppBoxDecorationImage(
                  height: 60.h,
                  width: 60.w,
                  imagePath:
                      "${AppConstants.IMAGE_UPLOADS_PATH}${lessonData[index].thumbnail}",
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text13Normal(
                        text: lessonData[index].name ?? "No Name Available",
                        color: AppColors.primaryText,
                      ),
                      // Text10Normal(
                      //   text: lessonData[index].description ??
                      //       "No Description Available",
                      //   color: AppColors.primaryText,
                      // ),
                    ],
                  ),
                ),
                //Expanded(child: Container()),
                AppImage(
                  imagePath: Img_Res.arrowRight,
                  width: 24.w,
                  height: 24.h,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
