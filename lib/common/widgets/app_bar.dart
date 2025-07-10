import 'package:course_app/common/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

AppBar buildAppBar({String title = ''}) {
  return AppBar(
    centerTitle: true,
    bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: Colors.grey.withOpacity(0.3),
          height: 1,
        )),
    title: Text16Normal(text: title, color: AppColors.primaryText),
  );
}

AppBar buildGlobalAppBar({String title = ''}) {
  return AppBar(
    centerTitle: true,
    title: Text16Normal(
      text: title,
      color: AppColors.primaryText,
      weight: FontWeight.bold,
    ),
  );
}
