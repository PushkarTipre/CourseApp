import 'package:course_app/common/widgets/course_tile_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/models/course_enties.dart';
import '../../../../common/routes/app_routes_name.dart';
import '../../../../common/utils/app_colors.dart';
import '../../../../common/utils/constants.dart';
import '../../../../common/widgets/text_widget.dart';

class CoursesBoughtWidgets extends StatelessWidget {
  final List<CourseItem> value;
  const CoursesBoughtWidgets({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return CourseTile(value: value);
  }
}
