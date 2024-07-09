import 'package:course_app/pages/signup/provider/register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'register_notifier.g.dart';

@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  @override
  Register_State build() {
    return Register_State();
  }

  void onUserNameChange(String name) {
    state = state.copyWith(userName: name);
  }

  void onEmailChange(String email) {
    state = state.copyWith(email: email);
  }

  void onUserPasswordChange(String password) {
    state = state.copyWith(password: password);
  }

  void onUserRePasswordChange(String password) {
    state = state.copyWith(confirmPassword: password);
  }
}
