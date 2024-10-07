import 'package:course_app/common/models/course_enties.dart';
import 'package:course_app/common/utils/constants.dart';
import 'package:course_app/common/utils/img_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/models/lesson_entities.dart';
import '../../../common/utils/app_colors.dart';
import '../../../common/widgets/app_shadows.dart';
import '../../../common/widgets/image_widgets.dart';
import '../../../common/widgets/text_widget.dart';

class AuthorMenu extends StatelessWidget {
  const AuthorMenu({super.key, required this.authorInfo});
  final AuthorItem authorInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 325.w,
      height: 220.h,
      child: Stack(
        children: [
          Container(
            width: 325.w,
            height: 160.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.h),
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(Img_Res.background),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: 325.w,
                margin: EdgeInsets.only(left: 20.h),
                child: Row(
                  children: [
                    Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20.w),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "${AppConstants.IMAGE_UPLOADS_PATH}${authorInfo.avatar}"),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 6.w),
                            child: Text13Normal(
                              text: "${authorInfo.name}",
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 6.w),
                            child: Text9Normal(
                              text: authorInfo.job ?? "",
                            )),
                        SizedBox(
                          height: 5.h,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AuthorTextAndIcon(
                                text: "10", icon: Img_Res.people, first: true),
                            AuthorTextAndIcon(
                                text: "90", icon: Img_Res.star, first: false),
                            AuthorTextAndIcon(
                                text: "12",
                                icon: Img_Res.downloadDetail,
                                first: false)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class AuthorTextAndIcon extends StatelessWidget {
  const AuthorTextAndIcon(
      {super.key, required this.text, required this.icon, required this.first});

  final String text;
  final String icon;
  final bool first;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: first == true ? 3.w : 20.w),
      child: Row(
        children: [
          AppImage(imagePath: icon),
          Text11Normal(
            text: text,
            color: AppColors.primaryThreeElementText,
          )
        ],
      ),
    );
  }
}

class AuthorDescription extends StatelessWidget {
  const AuthorDescription({super.key, required this.authorInfo});
  final AuthorItem authorInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325.w,
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text16Normal(
            text: "About me",
            color: AppColors.primaryText,
            weight: FontWeight.bold,
          ),
          Container(
            margin: EdgeInsets.only(top: 8.h),
            child: Text11Normal(
              text: authorInfo.description ?? "",
              color: AppColors.primaryThreeElementText,
            ),
          )
        ],
      ),
    );
  }
}

class AuthorCourses extends StatelessWidget {
  final List<CourseItem> authorCourseList;

  const AuthorCourses({
    super.key,
    required this.authorCourseList,
  });

  @override
  Widget build(BuildContext context) {
    //log("My course data: ${lessonData.length}");
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          authorCourseList.isNotEmpty
              ? const Text14Normal(
                  text: "Lessons List",
                  color: AppColors.primaryText,
                  weight: FontWeight.bold,
                )
              : const SizedBox(),
          SizedBox(
            height: 10.h,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: authorCourseList.length,
            itemBuilder: (_, index) {
              return Container(
                margin: EdgeInsets.only(top: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                width: 325.w,
                height: 80.h,
                decoration: appBoxShadow(
                  radius: 10.w,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  bR: 3,
                  sR: 2,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("/course_detail",
                        arguments: {"id": authorCourseList[index].id});
                  },
                  child: Row(
                    children: [
                      AppBoxDecorationImage(
                        height: 60.h,
                        width: 60.w,
                        imagePath:
                            "${AppConstants.IMAGE_UPLOADS_PATH}${authorCourseList[index].thumbnail}",
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
                              text: authorCourseList[index].name ??
                                  "No Name Available",
                              color: AppColors.primaryText,
                            ),
                            Text10Normal(
                              text:
                                  "There are ${authorCourseList[index].lesson_num} lessons" ??
                                      "No Description Available",
                              color: AppColors.primaryText,
                            ),
                          ],
                        ),
                      ),
                      //Expanded(child: Container()),
                      // AppImage(
                      //   imagePath: Img_Res.arrowRight,
                      //   width: 24.w,
                      //   height: 24.h,
                      // )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
