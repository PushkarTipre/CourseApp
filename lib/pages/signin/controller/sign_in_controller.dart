import 'dart:convert';

import 'package:course_app/common/global_loader/global_loader.dart';
import 'package:course_app/common/utils/constants.dart';
import 'package:course_app/global.dart';
import 'package:course_app/main.dart';
import 'package:course_app/pages/signin/repo/sign_in_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/models/user.dart';
import '../../../common/utils/pop_messages.dart';
import '../provider/sign_in_notifier.dart';

class Sign_In_Controller {
  // WidgetRef ref;
  Sign_In_Controller();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> handleSignIn(WidgetRef ref) async {
    var state = ref.read(sign_in_notifierProvider);
    String email = state.email;
    String password = state.password;

    emailController.text = email;
    passwordController.text = password;

    if (email.isEmpty || state.email.isEmpty) {
      toastInfo('Email is required');
      return;
    }
    if (password.isEmpty || state.password.isEmpty) {
      toastInfo('Password is required');
      return;
    }
    ref.read(appLoaderProvider.notifier).setLoaderValue(true);
    try {
      final cred = await SignInRepo.firebaseSignInRepo(email, password);

      if (cred.user == null) {
        toastInfo('User Not Found');
        return;
      } else if (!cred.user!.emailVerified) {
        toastInfo('You must verify your email before signing in');
        return;
      }
      var user = cred.user;
      if (user != null) {
        String? displayName = user.displayName;
        String? email = user.email;
        String? id = user.uid;
        String? photoUrl = user.photoURL;
        LoginRequestEntity loginRequestEntity = LoginRequestEntity();

        loginRequestEntity.avatar = photoUrl;
        loginRequestEntity.email = email;
        loginRequestEntity.open_id = id;
        loginRequestEntity.name = displayName;
        loginRequestEntity.type = 1;
        asyncPostAllDate(loginRequestEntity);
        print('User logged in');
      } else {
        toastInfo('Login error');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        toastInfo('your password is wrong');
      } else {
        toastInfo('An error occurred');
      }
      print(e.code);
      //toastInfo('An error occurred');
    } catch (e) {}
    ref.read(appLoaderProvider.notifier).setLoaderValue(false);
  }

  void asyncPostAllDate(LoginRequestEntity loginRequestEntity) {
    try {
      //User info in shared preferences used to remember user on device
      //var navigator = Navigator.of(ref.context);
      Global.storageService.setString(
          AppConstants.STORAGE_USER_PROFILE_KEY,
          jsonEncode(
              {'name': 'Hawk', 'email': 'psuhkar@gmail.com', 'age': 21}));

      Global.storageService
          .setString(AppConstants.STORAGE_USER_TOKEN_KEY, 'value');
      navKey.currentState
          ?.pushNamedAndRemoveUntil('/application', (route) => false);
    } catch (e) {}
  }
}
