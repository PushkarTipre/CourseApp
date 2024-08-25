import 'package:course_app/common/utils/img_res.dart';
import 'package:course_app/common/widgets/app_bar.dart';
import 'package:course_app/common/widgets/image_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/profile_widgets.dart';

class Profile_View extends StatefulWidget {
  const Profile_View({super.key});

  @override
  State<Profile_View> createState() => _Profile_ViewState();
}

class _Profile_ViewState extends State<Profile_View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildGlobalAppBar(title: "Profile"),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileImageWidgets(),
              ProfileNameWidgets(),
              ProfileDescriptionWidgets()
            ],
          ),
        ),
      ),
    );
  }
}
