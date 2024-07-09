import 'package:course_app/common/routes/routes.dart';
import 'package:course_app/common/utils/app_styles.dart';
import 'package:course_app/common/utils/http_util.dart';
import 'package:course_app/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  await Global.init();
  HttpUtil();
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
          title: 'Flutter Demo',
          theme: AppTheme.appThemeData,

          // initialRoute: "/",
          // routes: routesMap,
          onGenerateRoute: (settings) =>
              AppPages.generateRouteSettings(settings),
          //home: Welcome(),
        );
      },
    );
  }
}