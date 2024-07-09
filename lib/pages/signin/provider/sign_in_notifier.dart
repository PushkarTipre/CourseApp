import 'package:course_app/pages/signin/provider/sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//StateNotifier saves state of the app
class Sign_In_Notifier extends StateNotifier<Sign_In_State> {
  Sign_In_Notifier() : super(const Sign_In_State());

  void onEmailChange(String email) {
    state = state.copyWith(email: email);
  }

  void onUserPasswordChange(String password) {
    state = state.copyWith(password: password);
  }
}

final sign_in_notifierProvider =
    StateNotifierProvider<Sign_In_Notifier, Sign_In_State>((ref) {
  return Sign_In_Notifier();
});
