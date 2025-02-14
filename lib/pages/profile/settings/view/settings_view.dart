import 'package:course_app/common/routes/app_routes_name.dart';
import 'package:course_app/common/utils/img_res.dart';
import 'package:course_app/common/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/utils/constants.dart';
import '../../../../global.dart';

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
                    title: Text("Confirm logout"),
                    content: Text("Confirm logout."),
                    actions: [
                      TextButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Confirm"),
                        onPressed: () {
                          Global.storageService
                              .remove(AppConstants.STORAGE_USER_PROFILE_KEY);
                          Global.storageService
                              .remove(AppConstants.STORAGE_USER_TOKEN_KEY);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutesName.SIGN_IN,
                              (Route<dynamic> route) => false);
                        },
                      )
                    ],
                  );
                });
          },
          child: Container(
            height: 100.h,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Img_Res.logout), fit: BoxFit.fitHeight)),
          ),
        ),
      ),
    );
  }
}
