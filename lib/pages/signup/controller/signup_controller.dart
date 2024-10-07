import 'package:course_app/common/global_loader/global_loader.dart';
import 'package:course_app/common/utils/pop_messages.dart';
import 'package:course_app/pages/signup/repo/sign_up_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/register_notifier.dart';

class SignupController {
  final WidgetRef ref;
  SignupController({required this.ref});

  Future<void> handleSignup() async {
    var context = Navigator.of(ref.context);
    var state = ref.read(registerNotifierProvider);

    String email = state.email;
    String userName = state.userName;

    String password = state.password;
    String confirmPassword = state.confirmPassword;

    if (userName.isEmpty || state.userName.isEmpty) {
      toastInfo('Username is required');
      return;
    }
    if (userName.length < 6 || state.userName.length < 6) {
      toastInfo('Username must be at least 6 characters');
      return;
    }

    if (email.isEmpty || state.email.isEmpty) {
      toastInfo('Email is required');
      return;
    }
    if ((state.password.isEmpty || state.confirmPassword.isEmpty) ||
        (password.isEmpty || confirmPassword.isEmpty)) {
      toastInfo('Password is empty');
      return;
    }
    if ((state.password != state.confirmPassword) ||
        (password != confirmPassword)) {
      toastInfo('Password does not match');
      return;
    }
    ref.read(appLoaderProvider.notifier).setLoaderValue(true);

    try {
      final credential = await SignInRepo.firebaseSignUpRepo(email, password);
      if (kDebugMode) {
        print(credential);
      }
      if (credential.user != null) {
        await credential.user!.sendEmailVerification();
        await credential.user!.updateDisplayName(userName);
        String photoUrl = "default.png";
        await credential.user!.updatePhotoURL(photoUrl);
        toastInfo(
            'An email has been sent to your account. Please confirm to access your account');
        context.pop();

        //get user photo url
        //set user photo url
      }
    } on FirebaseAuthException catch (e) {
      ref.read(appLoaderProvider.notifier).setLoaderValue(false);

      if (e.code == 'weak-password') {
        toastInfo('Password is too weak');
        return;
      } else if (e.code == 'email-already-in-use') {
        toastInfo('Email is already in use');
        return;
      } else if (e.code == 'user-not-found') {
        toastInfo('User not found');
        return;
      }
      //toastInfo('An error occurred');
    } catch (e) {}
    //show register page
    ref.watch(appLoaderProvider.notifier).setLoaderValue(false);
  }
}
