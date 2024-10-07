import 'package:course_app/common/widgets/course_tile_widgets.dart';
import 'package:flutter/material.dart';

import '../../../../common/models/course_enties.dart';

class CoursesSearchWidget extends StatelessWidget {
  final List<CourseItem> value;
  const CoursesSearchWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return CourseTile(value: value);
  }
}
