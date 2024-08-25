import 'package:course_app/common/utils/app_colors.dart';
import 'package:course_app/common/utils/constants.dart';
import 'package:course_app/common/widgets/text_widget.dart';
import 'package:course_app/pages/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/img_res.dart';
import '../../../common/widgets/image_widgets.dart';

class ProfileImageWidgets extends StatelessWidget {
  const ProfileImageWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var profileImage = ref.watch(profileControllerProvider);
        return Container(
          alignment: Alignment.bottomRight,
          width: 80.w,
          height: 80.w,
          decoration: profileImage.avatar == null
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(40.w),
                  image:
                      const DecorationImage(image: AssetImage(Img_Res.headPic)),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(40.w),
                  image: DecorationImage(
                    image: NetworkImage(
                        "${AppConstants.SERVER_API_URL}${profileImage.avatar}"),
                  ),
                ),
          child: AppImage(
            width: 25.w,
            height: 25.h,
            imagePath: Img_Res.edit_img,
          ),
        );
      },
    );
  }
}

class ProfileNameWidgets extends StatelessWidget {
  const ProfileNameWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var profileName = ref.watch(profileControllerProvider);
        return Container(
          margin: EdgeInsets.only(top: 12.h),
          child: Text13Normal(
              text: profileName.name != null ? "${profileName.name}" : ""),
        );
      },
    );
  }
}

class ProfileDescriptionWidgets extends StatelessWidget {
  const ProfileDescriptionWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var profileName = ref.watch(profileControllerProvider);
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          margin: EdgeInsets.only(top: 5.h, bottom: 10.h),
          child: Text9Normal(
            text: profileName.description != null
                ? "${profileName.description}"
                : "I am A Developer",
            color: AppColors.primarySecondaryElementText,
          ),
        );
      },
    );
  }
}
