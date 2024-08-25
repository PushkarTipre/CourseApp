import 'package:course_app/common/api/course_api.dart';
import 'package:course_app/common/models/course_enties.dart';
import 'package:course_app/common/models/entities.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global.dart';
part 'home_controller.g.dart';

@Riverpod(keepAlive: true)
class HomeScreenBannerIndex extends _$HomeScreenBannerIndex {
  @override
  int build() => 0;

  void setIndex(int index) {
    state = index;
  }
}

@riverpod
class HomeUserProfile extends _$HomeUserProfile {
  @override
  FutureOr<UserProfile> build() {
    return Global.storageService.getUserProfile();
  }
}

@Riverpod(keepAlive: true)
class HomeCourseList extends _$HomeCourseList {
  Future<List<CourseItem>?> fetchCourseList() async {
    var result = await CourseAPI.courseList();
    if (result.code == 200) {
      return result.data;
    }
    return null;
  }

  @override
  FutureOr<List<CourseItem>?> build() async {
    return fetchCourseList();
  }
}
