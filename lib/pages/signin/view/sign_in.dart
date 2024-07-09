import 'package:course_app/common/global_loader/global_loader.dart';
import 'package:course_app/common/widgets/text_widget.dart';
import 'package:course_app/pages/signin/controller/sign_in_controller.dart';
import 'package:course_app/pages/signin/widgets/sign_in_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/app_colors.dart';
import '../../../common/utils/img_res.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/app_textfields.dart';
import '../../../common/widgets/button_widgets.dart';
import '../provider/sign_in_notifier.dart';

class Sign_In extends ConsumerStatefulWidget {
  const Sign_In({super.key});

  @override
  ConsumerState<Sign_In> createState() => _Sign_InState();
}

class _Sign_InState extends ConsumerState<Sign_In> {
  late Sign_In_Controller _controller;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _controller = Sign_In_Controller();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final signInProvider = ref.watch(sign_in_notifierProvider);
    final loader = ref.watch(appLoaderProvider);

    return Scaffold(
      appBar: buildAppBar(title: 'Sign In'),
      body: loader == false
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  thirdPartyLogin(),
                  Center(
                      child: const Text14Normal(
                          text: 'Or use your email account to login')),
                  SizedBox(
                    height: 50.h,
                  ),
                  appTextField(
                      controller: _controller.emailController,
                      text: 'Email',
                      iconName: Img_Res.user,
                      hintText: 'Enter your email',
                      func: (value) => ref
                          .read(sign_in_notifierProvider.notifier)
                          .onEmailChange(value)),
                  SizedBox(
                    height: 20.h,
                  ),
                  appTextField(
                      controller: _controller.passwordController,
                      text: 'Password',
                      iconName: Img_Res.lock,
                      hintText: 'Enter your password',
                      obscureText: true,
                      func: (value) => ref
                          .read(sign_in_notifierProvider.notifier)
                          .onUserPasswordChange(value)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 25.w),
                    child: textUnderline(text: 'Forgot Password?'),
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  Center(
                      child: appButton(
                          text: 'Login',
                          onPressed: () {
                            _controller.handleSignIn(ref);
                          })),
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: appButton(
                        text: 'Register',
                        isLogin: false,
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        }),
                  )
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
              color: AppColors.primaryElement,
            )),
    );
  }
}
