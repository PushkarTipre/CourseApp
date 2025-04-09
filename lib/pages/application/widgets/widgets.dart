import 'package:course_app/common/utils/app_colors.dart';
import 'package:course_app/common/utils/img_res.dart';
import 'package:course_app/common/widgets/image_widgets.dart';
import 'package:course_app/pages/home/view/home.dart';
import 'package:course_app/pages/mycourses/view/my_courses.dart';
import 'package:course_app/pages/profile/view/profile_view.dart';
import 'package:course_app/pages/search/view/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../category_course/view/category_course.dart';

var bottomTabs = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
      icon: _bottomContainer(),
      activeIcon: _bottomContainer(color: AppColors.primaryElement),
      backgroundColor: AppColors.primaryBackground,
      label: 'Home'),
  BottomNavigationBarItem(
      icon: _bottomContainer(imagePath: Img_Res.search),
      activeIcon: _bottomContainer(
          color: AppColors.primaryElement, imagePath: Img_Res.search),
      backgroundColor: AppColors.primaryBackground,
      label: 'Search'),
  BottomNavigationBarItem(
      icon: _bottomContainer(imagePath: Img_Res.play_Circle),
      activeIcon: _bottomContainer(
          color: AppColors.primaryElement, imagePath: Img_Res.play_Circle),
      backgroundColor: AppColors.primaryBackground,
      label: 'Play'),
  BottomNavigationBarItem(
      icon: _bottomContainer(imagePath: Img_Res.book),
      activeIcon: _bottomContainer(
          color: AppColors.primaryElement, imagePath: Img_Res.book),
      backgroundColor: AppColors.primaryBackground,
      label: 'Chat'),
  BottomNavigationBarItem(
      icon: _bottomContainer(imagePath: Img_Res.profilePhoto),
      activeIcon: _bottomContainer(
          color: AppColors.primaryElement, imagePath: Img_Res.profilePhoto),
      backgroundColor: AppColors.primaryBackground,
      label: 'Profile'),
];

Widget _bottomContainer(
    {double width = 15,
    double height = 15,
    String imagePath = Img_Res.home,
    Color color = AppColors.primaryFourElementText}) {
  return SizedBox(
    width: width.w,
    height: height.w,
    child: appImageWithColour(iconPath: imagePath, color: color),
  );
}

Widget appScreens({int index = 0}) {
  List<Widget> screens = [
    const Home(),
    const Search(),
    const MyCourses(),
    const CourseListScreen(),
    const Profile()
  ];
  return screens[index];
}
