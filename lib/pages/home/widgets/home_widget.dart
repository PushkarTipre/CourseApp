import 'package:course_app/common/utils/app_colors.dart';
import 'package:course_app/common/utils/img_res.dart';
import 'package:course_app/common/widgets/app_shadows.dart';
import 'package:course_app/common/widgets/image_widgets.dart';
import 'package:course_app/common/widgets/text_widget.dart';
import 'package:course_app/pages/home/controller/home_controller.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global.dart';

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    print("MY username");
    return Container(
      child: text24Normal(
          text: Global.storageService.getUserProfile()["name"] ?? "",
          //color: AppColors.pri,
          fontWeight: FontWeight.bold),
    );
  }
}

class HelloText extends StatelessWidget {
  const HelloText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: text24Normal(
          text: "Hello",
          color: AppColors.primaryThreeElementText,
          fontWeight: FontWeight.bold),
    );
  }
}


class HomeBanner extends StatelessWidget {
  final PageController controller;
  final WidgetRef ref;
  const HomeBanner({super.key, required this.controller, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 325.w,
          height: 160.h,
          child: PageView(
            controller: controller,
            onPageChanged: (pageIndex) {
              //print(pageIndex);
              ref
                  .read(homeScreenBannerIndexProvider.notifier)
                  .setIndex(pageIndex);
            },
            children: [
              _bannerContainer(imgPath: Img_Res.banner1),
              _bannerContainer(imgPath: Img_Res.banner2),
              _bannerContainer(imgPath: Img_Res.banner3),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        DotsIndicator(
          mainAxisAlignment: MainAxisAlignment.center,
          dotsCount: 3,
          position: ref.watch(homeScreenBannerIndexProvider),
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(24, 8),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.w),
            ),
          ),
        )
      ],
    );
  }
}

Widget _bannerContainer({required String imgPath}) {
  return Container(
    width: 325.w,
    height: 160.h,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(imgPath), fit: BoxFit.fill),
    ),
  );
}

AppBar homeAppBar() {
  return AppBar(
    title: Container(
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appImage(width: 18.w, height: 12.h, iconPath: Img_Res.menu),
          GestureDetector(child: const AppBoxDecorationImage())
        ],
      ),
    ),
  );
}

class HomeMenuBar extends StatelessWidget {
  const HomeMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text16Normal(
                text: "Choose your course",
                weight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
              GestureDetector(
                child: Text10Normal(
                  text: "See all",
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          children: [
            Container(
              decoration:
                  appBoxShadow(color: AppColors.primaryElement, radius: 7.w),
              padding: EdgeInsets.only(
                  left: 15.w, right: 15.w, top: 5.h, bottom: 5.h),
              child: Text11Normal(text: "Popular"),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.w),
              child: Text11Normal(
                text: "Popular",
                color: AppColors.primaryThreeElementText,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.w),
              child: Text11Normal(
                text: "Newest",
                color: AppColors.primaryThreeElementText,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class CourseItemGrid extends StatelessWidget {
  const CourseItemGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 14, mainAxisSpacing: 14),
          itemCount: 6,
          itemBuilder: (_, int index) {
            return appImage();
          }),
    );
  }
}
