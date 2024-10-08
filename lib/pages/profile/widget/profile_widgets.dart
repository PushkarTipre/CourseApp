import 'package:course_app/common/utils/img_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/routes/app_routes_name.dart';
import '../../../common/utils/app_colors.dart';
import '../../../common/utils/constants.dart';
import '../../../common/widgets/image_widgets.dart';
import '../../../common/widgets/text_widget.dart';
import '../controller/profile_controller.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var profileImage = ref.read(profileControllerProvider);
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutesName.EDIT_PROFILE);
          },
          child: Container(
              alignment: Alignment.bottomRight,
              width: 80.w,
              height: 80.h,
              decoration: profileImage.avatar == null
                  ? BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20.w),
                      image: const DecorationImage(
                          image: AssetImage(Img_Res.headPic)))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(20.w),
                      image: DecorationImage(
                          image: NetworkImage(
                              "${AppConstants.IMAGE_UPLOADS_PATH}${profileImage.avatar}"))),
              child: AppImage(
                  width: 25.w, height: 25.h, imagePath: Img_Res.edit_img)),
        );
      },
    );
  }
}

class ProfileNameWidget extends StatelessWidget {
  const ProfileNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var profileName = ref.read(profileControllerProvider);
        return Container(
          margin: EdgeInsets.only(top: 12.h),
          child: Text13Normal(
              text: profileName.name != null ? "${profileName.name}" : ""),
        );
      },
    );
  }
}

class ProfileDescriptionWidget extends StatelessWidget {
  const ProfileDescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var profileName = ref.read(profileControllerProvider);
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          margin: EdgeInsets.only(top: 5.h, bottom: 10),
          child: Text9Normal(
            text: profileName.description != null
                ? "${profileName.description}"
                : "Empty",
            color: AppColors.primarySecondaryElementText,
          ),
        );
      },
    );
  }
}
