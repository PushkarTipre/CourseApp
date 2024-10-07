import 'package:course_app/global.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../common/models/user.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  UserProfile build() => Global.storageService.getUserProfile();
}
