import 'package:course_app/common/global_loader/global_loader.dart';
import 'package:course_app/common/widgets/text_widget.dart';
import 'package:course_app/pages/signin/controller/sign_in_controller.dart';

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

  bool obscurePassword = true;

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
                  Container(
                    width: double.infinity,
                    height: 220.h,
                    margin:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Stack(
                        children: [
                          // Your asset image
                          Image.asset(
                            Img_Res.pvg, // Replace with your actual asset path
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          // Gradient overlay for better text visibility if needed
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  AppColors.primaryElement.withOpacity(0.5),
                                ],
                              ),
                            ),
                          ),
                          // Welcome text overlay
                        ],
                      ),
                    ),
                  ),

                  // thirdPartyLogin(),
                  // Center(
                  //     child: const Text14Normal(
                  //         text: 'Or use your email account to login')),
                  SizedBox(
                    height: 20.h,
                  ),
                  AppTextFields(
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
                  AppTextFields(
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                      controller: _controller.passwordController,
                      text: 'Password',
                      iconName: Img_Res.lock,
                      hintText: 'Enter your password',
                      obscureText: obscurePassword,
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
                    height: 50.h,
                  ),
                  Center(
                      child: AppButton(
                          text: 'Login',
                          onPressed: () {
                            _controller.handleSignIn(ref);
                          })),
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: AppButton(
                        text: 'Register',
                        isLogin: false,
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        }),
                  )
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
              color: AppColors.primaryElement,
            )),
    );
  }
}
