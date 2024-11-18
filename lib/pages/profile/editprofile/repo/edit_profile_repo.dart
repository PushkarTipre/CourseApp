import 'package:course_app/common/models/UserRequestEntity.dart';

import '../../../../common/models/user.dart';
import '../../../../common/utils/http_util.dart';

class EditProfileRepo {
  static Future<UserLoginResponseEntity> updateUserProfile(
      UserRequestEntity? updatedProfile) async {
    var response = await HttpUtil().post(
      "api/user/update",
      queryParameters: updatedProfile?.toJson(),
    );
    return UserLoginResponseEntity.fromJson(response);
  }
}
