import 'package:carpooling_beta/app/OnBoarding/presentation/controllers/onboarding_controller.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingView extends GetView<OnboardingController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => controller.isLoading.value
            ? CircularProgressIndicator()
            : IntroductionScreen(
                globalBackgroundColor: Colors.white,
                pages: [
                  for (OnboardingPage page in controller.pages)
                    PageViewModel(
                      titleWidget: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.naturalColor1,
                            fontFamily: AppTheme.primaryFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                      ),
                      bodyWidget: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          page.body,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.naturalColor3,
                            fontFamily: AppTheme.primaryFont,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      image: Container(
                        padding: EdgeInsets.only(top: 15),
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: SvgPicture.asset(
                            page.picture,
                          ),
                        ),
                      ),
                    ),
                ],
                next: Text(
                  'Next',
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontFamily: AppTheme.primaryFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                showSkipButton: true,
                skip: Text(
                  "Skip",
                  style: TextStyle(
                    color: AppTheme.naturalColor2,
                    fontFamily: AppTheme.primaryFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                done: Text(
                  "Done",
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontFamily: AppTheme.primaryFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                onDone: () {
                  Get.toNamed('/login');
                },
                dotsDecorator: DotsDecorator(
                  size: const Size.square(10.0),
                  activeSize: const Size(20.0, 10.0),
                  activeColor: AppTheme.primaryColor,
                  color: Colors.black26,
                  spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
      ),
    );
  }
}
