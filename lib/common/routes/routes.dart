import 'package:course_app/common/routes/app_routes_name.dart';
import 'package:course_app/pages/application/view/application.dart';
import 'package:course_app/pages/home/view/home.dart';
import 'package:course_app/pages/signin/view/sign_in.dart';
import 'package:course_app/pages/signup/view/sign_up.dart';
import 'package:course_app/pages/welcome/view/welcome.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../global.dart';

class AppPages {
  static List<RouteEntity> routes() {
    return [
      RouteEntity(path: AppRoutesName.WELCOME, page: Welcome()),
      RouteEntity(path: AppRoutesName.SIGN_IN, page: const Sign_In()),
      RouteEntity(path: AppRoutesName.REGISTER, page: const Sign_Up()),
      RouteEntity(path: AppRoutesName.APPLICATION, page: const Application()),
      RouteEntity(path: AppRoutesName.HOME, page: const Home()),
    ];
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (kDebugMode) {
      print('Clicked route is ${settings.name}');
    }

    if (settings.name != null) {
      var result = routes().where((element) => element.path == settings.name);

      if (result.isNotEmpty) {
        bool deviceFirstTime = Global.storageService.getDeviceFirstOpen();

        if (result.first.path == AppRoutesName.WELCOME && deviceFirstTime) {
          print('On welcome route');

          bool isLoggedIn = Global.storageService.isLoggedIn();
          if (isLoggedIn) {
            print('User is logged in');
            return MaterialPageRoute(
                builder: (_) => const Application(), settings: settings);
          } else {
            return MaterialPageRoute(
                builder: (_) => const Sign_In(), settings: settings);
          }
        } else {
          if (kDebugMode) {
            print('App run first time');
          }
        }
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    return MaterialPageRoute(builder: (_) => Welcome(), settings: settings);
  }
}

class RouteEntity {
  String path;
  Widget page;
  RouteEntity({required this.path, required this.page});
}