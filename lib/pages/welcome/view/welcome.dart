import 'package:course_app/common/utils/img_res.dart';
import 'package:course_app/pages/welcome/provider/welcome_notifier.dart';
import 'package:course_app/pages/welcome/widgets/widgets.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Welcome extends ConsumerWidget {
  Welcome({super.key});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexDotProvider);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              margin: EdgeInsets.only(top: 30.h),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  PageView(
                    onPageChanged: (value) {
                      ref.read(indexDotProvider.notifier).changeIndex(value);
                    },
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    children: [
                      AppOnboardingPage(
                          controller: _controller,
                          context: context,
                          imagePath: Img_Res.reading,
                          title: 'First see Learning',
                          subTitle:
                              'Forget about paper, now all learning in one place',
                          index: 1),
                      AppOnboardingPage(
                          controller: _controller,
                          imagePath: Img_Res.man,
                          title: 'Connect with Everyone',
                          subTitle:
                              "Always keep in touch with your tutor and friends. Let's get connected",
                          index: 2,
                          context: context),
                      AppOnboardingPage(
                          controller: _controller,
                          context: context,
                          imagePath: Img_Res.boy,
                          title: 'Always fascinated with learning',
                          subTitle:
                              'Learning is fun, let us help you to make it more fun',
                          index: 3),
                    ],
                  ),
                  Positioned(
                    bottom: 50,
                    child: DotsIndicator(
                      mainAxisAlignment: MainAxisAlignment.center,
                      dotsCount: 3,
                      position: index,
                      onTap: (index) {
                        _controller.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      decorator: DotsDecorator(
                        size: const Size.square(9.0),
                        activeSize: const Size(24, 8),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
