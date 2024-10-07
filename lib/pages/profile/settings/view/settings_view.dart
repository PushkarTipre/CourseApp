import 'package:course_app/common/routes/app_routes_name.dart';
import 'package:course_app/common/utils/constants.dart';
import 'package:course_app/common/utils/img_res.dart';
import 'package:course_app/common/widgets/app_bar.dart';
import 'package:course_app/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildGlobalAppBar(title: "Settings"),
      body: Center(
        child: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirm Logout"),
                    content: Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Global.storageService
                              .remove(AppConstants.STORAGE_USER_PROFILE_KEY);
                          Global.storageService
                              .remove(AppConstants.STORAGE_USER_TOKEN_KEY);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutesName.SIGN_IN,
                              (Route<dynamic> route) => false);
                        },
                        child: Text("Confirm"),
                      ),
                    ],
                  );
                });
          },
          child: Container(
            height: 100.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(
                  Img_Res.logout,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
