import 'package:course_app/common/services/storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'firebase_options.dart';

class Global {
  static late StorageService storageService;
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    storageService = await StorageService().init();
  }
}
