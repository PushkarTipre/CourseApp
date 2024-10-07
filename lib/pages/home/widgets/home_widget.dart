import 'dart:developer';

import 'package:course_app/common/routes/app_routes_name.dart';
import 'package:course_app/common/utils/app_colors.dart';
import 'package:course_app/common/utils/constants.dart';
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
    return Container(
      child: text24Normal(
          text: Global.storageService.getUserProfile().name ?? "",
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

AppBar homeAppBar(WidgetRef ref) {
  var profileState = ref.watch(homeUserProfileProvider);
  return AppBar(
    title: Container(
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("PVG COET",
              style: TextStyle(color: AppColors.primaryText)),
          profileState.when(
            data: (data) {
              log("This is HERE :${data.avatar}");
              return GestureDetector(
                  child: AppBoxDecorationImage(
                imagePath: "${AppConstants.IMAGE_UPLOADS_PATH}${data.avatar}",
              ));
            },
            error: (error, stack) =>
                AppImage(width: 18.w, height: 12.h, imagePath: Img_Res.menu),
            loading: () => const CircularProgressIndicator(),
          )
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
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text16Normal(
                text: "Choose your course",
                weight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
              // GestureDetector(
              //   child: Text10Normal(
              //     text: "See all",
              //   ),
              // )
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
  final WidgetRef ref;
  const CourseItemGrid({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    final courseState = ref.watch(homeCourseListProvider);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: courseState.when(
          data: (data) => GridView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.6),
              itemCount: data?.length,
              itemBuilder: (_, int index) {
                return AppBoxDecorationImage(
                  fit: BoxFit.fitHeight,
                  imagePath:
                      "${AppConstants.IMAGE_UPLOADS_PATH}${data?[index].thumbnail}",
                  courseItem: data![index],
                  func: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutesName.COURSE_DETAIL, arguments: {
                      "id": data[index].id!,
                    });
                  },
                );
              }),
          error: (error, stackTrace) {
            print(stackTrace.toString());
            return Center(child: Text(error.toString()));
          },
          loading: () => Center(
                child: Text("Loading"),
              )),
    );
  }
}
