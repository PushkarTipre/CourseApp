import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/models/course_enties.dart';
import '../repo/course_author_repo.dart';

part 'author_controller.g.dart';

@riverpod
class AuthorCourseListController extends _$AuthorCourseListController {
  @override
  FutureOr<List<CourseItem>?> build() async {
    return [];
  }

  void init(String token) {
    loadCourseData(token);
  }

  loadCourseData(String token) async {
    AuthorRequestEntity authorRequestEntity = AuthorRequestEntity();
    authorRequestEntity.token = token;
    var response =
        await CourseAuthorRepo.authorCourseList(params: authorRequestEntity);
    if (response.code == 200) {
      state = AsyncValue.data(response.data);
    }
  }
}

@riverpod
class CourseAuthorController extends _$CourseAuthorController {
  @override
  FutureOr<AuthorItem?> build() async {
    return null;
  }

  void init(String token) {
    loadAuthor(token);
  }

  loadAuthor(String token) async {
    AuthorRequestEntity authorRequestEntity = AuthorRequestEntity();
    authorRequestEntity.token = token;
    var response =
        await CourseAuthorRepo.courseAuthor(params: authorRequestEntity);
    if (response.code == 200) {
      state = AsyncValue.data(response.data);
    }
  }
}
