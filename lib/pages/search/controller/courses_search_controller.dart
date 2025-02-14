import 'dart:developer';
import 'package:course_app/pages/buy_course/repo/buy_course_repo.dart';
import 'package:course_app/pages/search/repo/courses_search_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/models/course_enties.dart';

// part 'courses_search_controller.g.dart';
//
// @riverpod
class CoursesSearchController extends AsyncNotifier<List<CourseItem>?> {
  @override
  FutureOr<List<CourseItem>?> build() async {
    final response = await CoursesSearchRepo.coursesDefaultSearch();
    if (response.code == 200) {
      return response.data;
    } else {
      log("Request failed ${response.code} ${response.msg}");
    }
    return [];
  }

  reloadSearchData() async {
    final response = await CoursesSearchRepo.coursesDefaultSearch();
    if (response.code == 200) {
      state = AsyncValue.data(response.data);
      return;
    }
    state = AsyncValue.data([]);
  }

  searchData(String search) async {
    SearchRequestEntity searchRequestEntity =
        SearchRequestEntity(search: search);
    searchRequestEntity.search = search;
    var response =
        await CoursesSearchRepo.coursesSearch(params: searchRequestEntity);

    if (response.code == 200) {
      state = AsyncValue.data(response.data);
    } else {
      state = AsyncValue.data([]);
    }
  }
}

final coursesSearchControllerProvider =
    AsyncNotifierProvider<CoursesSearchController, List<CourseItem>?>(
        CoursesSearchController.new);
