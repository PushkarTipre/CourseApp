import 'dart:convert';
import 'dart:developer';

import 'package:course_app/common/global_loader/global_loader.dart';
import 'package:course_app/common/utils/constants.dart';

import 'package:course_app/global.dart';
import 'package:course_app/main.dart';
import 'package:course_app/pages/signin/repo/sign_in_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
      final cred = await SignInRepo.firebaseSignIn(email, password);

      if (cred.user == null) {
        toastInfo('User Not Found');
        return;
      }
      if (!cred.user!.emailVerified) {
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
        loginRequestEntity.name = displayName;
        loginRequestEntity.email = email;
        loginRequestEntity.open_id = id;
        loginRequestEntity.type = 1;
        asyncPostAllDate(loginRequestEntity);
        log('User logged in');
      } else {
        toastInfo('Login error');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toastInfo("User not found");
      } else if (e.code == 'wrong-password') {
        toastInfo("Your password is wrong");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    ref.read(appLoaderProvider.notifier).setLoaderValue(false);
  }

  Future<void> asyncPostAllDate(LoginRequestEntity loginRequestEntity) async {
    var result = await SignInRepo.login(params: loginRequestEntity);
    if (result.code == 200) {
      try {
        Global.storageService.setString(
            AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(result.data));
        Global.storageService.setString(
            AppConstants.STORAGE_USER_TOKEN_KEY, result.data!.access_token!);

        navKey.currentState
            ?.pushNamedAndRemoveUntil('/application', (route) => false);
      } catch (e) {}
    } else {
      toastInfo("Login Error");
    }
  }
}
