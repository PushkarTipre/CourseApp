import 'package:firebase_auth/firebase_auth.dart';

class SignInRepo {
  static Future<UserCredential> firebaseSignUpRepo(
      String email, String password) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // Force token refresh and reload user data
    await FirebaseAuth.instance.currentUser?.getIdToken(true);
    await FirebaseAuth.instance.currentUser?.reload();

    // // Logging for verification
    // print("User signed up: ${credential.user?.uid}");
    // print("User's refreshToken after reload: ${credential.user?.refreshToken}");

    return credential;
  }
}
