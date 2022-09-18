import 'package:get/get.dart';
import 'package:carpooling_beta/app/OnBoarding/presentation/controllers/onboarding_controller.dart';

class OnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(
      () => OnboardingController(),
    );
  }
}
