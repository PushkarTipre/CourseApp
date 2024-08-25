import 'package:course_app/common/global_loader/global_loader.dart';
import 'package:course_app/common/utils/app_colors.dart';
import 'package:course_app/common/utils/img_res.dart';
import 'package:course_app/common/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/app_textfields.dart';
import '../../../common/widgets/button_widgets.dart';
import '../controller/signup_controller.dart';
import '../provider/register_notifier.dart';

class Sign_Up extends ConsumerStatefulWidget {
  const Sign_Up({super.key});

  @override
  ConsumerState<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends ConsumerState<Sign_Up> {
  late SignupController _controller;
  @override
  void initState() {
    // TODO: implement initState
    _controller = SignupController(ref: ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final regProvider = ref.watch(registerNotifierProvider);
    final loader = ref.watch(appLoaderProvider);
    return Scaffold(
      appBar: buildAppBar(title: 'Sign Up'),
      body: loader == false
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  const Center(
                    child:
                        Text14Normal(text: 'Enter your details below & signup'),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  appTextField(
                    text: 'User Name',
                    iconName: Img_Res.user,
                    hintText: 'Enter your User Name',
                    func: (value) {
                      ref
                          .read(registerNotifierProvider.notifier)
                          .onUserNameChange(value);
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  appTextField(
                    text: 'Email',
                    iconName: Img_Res.user,
                    hintText: 'Enter your email address',
                    func: (value) {
                      ref
                          .read(registerNotifierProvider.notifier)
                          .onEmailChange(value);
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  appTextField(
                    text: 'Password',
                    iconName: Img_Res.lock,
                    hintText: 'Enter your password',
                    obscureText: true,
                    func: (value) {
                      ref
                          .read(registerNotifierProvider.notifier)
                          .onUserPasswordChange(value);
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  appTextField(
                    text: 'Confirm Password',
                    iconName: Img_Res.lock,
                    hintText: 'Enter your password again',
                    obscureText: true,
                    func: (value) {
                      ref
                          .read(registerNotifierProvider.notifier)
                          .onUserRePasswordChange(value);
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    child: const Text14Normal(
                        text:
                            'By creating an account you are agreeing to our terms and condition'),
                  ),
                  SizedBox(
                    height: 85.h,
                  ),
                  Center(
                    child: AppButton(
                      text: 'Signup',
                      isLogin: true,
                      onPressed: () => _controller.handleSignup(),
                    ),
                  )
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
                color: AppColors.primaryElement,
              ),
            ),
    );
  }
}
