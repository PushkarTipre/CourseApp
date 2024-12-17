
import 'package:course_app/common/routes/routes.dart';
import 'package:course_app/common/utils/app_styles.dart';

import 'package:course_app/global.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WebViewPlatform.instance = WebViewPlatform.instance;
  await Global.init();
  //HttpUtil().post("api/login");
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  runApp(const ProviderScope(child: MyApp()));
}

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navKey,
          title: 'Ekaksha',
          theme: AppTheme.appThemeData,
          onGenerateRoute: (settings) =>
              AppPages.generateRouteSettings(settings),
        );
      },
    );
  }
}
