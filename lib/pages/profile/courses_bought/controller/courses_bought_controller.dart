import 'dart:async';

import 'package:course_app/pages/profile/courses_bought/repo/courses_bought_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../common/models/course_enties.dart';
part 'courses_bought_controller.g.dart';

@riverpod
class CoursesBoughtController extends _$CoursesBoughtController {
  CoursesBoughtController() : super();

  @override
  FutureOr<List<CourseItem>?> build() async {
    final response = await CoursesBoughtRepo.coursesBought();
    if (response.code == 200) {
      return response.data;
    } else {
      print("Request failed with status: ${response.msg}.");
    }
  }
}
