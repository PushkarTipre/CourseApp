import 'dart:developer';

import 'package:course_app/common/services/storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'firebase_options.dart';

class Global {
  static late StorageService storageService;
  static Future init() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      storageService = await StorageService().init();
      log('Global.init() completed successfully');
    } catch (e) {
      log('Error in Global.init(): $e');
      rethrow;
    }
  }
}
