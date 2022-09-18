import 'package:carpooling_beta/app/core/local_database/operations/user_operations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final List<OnboardingPage> pages = [
    OnboardingPage(
      title: 'Partage des frais',
      body:
          'A plusieur on peut faire des économies sur les frais de carburant et du peages.',
      picture: 'assets/onboarding_page1.svg',
    ),
    OnboardingPage(
      title: 'Recontre conviviale',
      body:
          'C\'est fini le temps de voyager seul, tout s\'ennuyant avec sa play liste démoder.',
      picture: 'assets/onboarding_page2.svg',
    ),
    OnboardingPage(
      title: 'Geste ecologique pour notre planete',
      body:
          'Chaque voiture de moins c\'est de tonnes de CO2 de moins dans notre atmosphère, que nous préserverons pour nos enfants.',
      picture: 'assets/onboarding_page3.svg',
    ),
  ];

  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    final user = await UserLocalDataBaseOperations().get();
    if (user == null) {
      print('USER ID:');
      print(user!.id.toString());
      Get.toNamed('/home');
      isLoading.value = false;
    } else {
      // print('USER ID NOT FOUND');
      // Get.toNamed('/login');
      isLoading.value = false;
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

class OnboardingPage {
  String title;
  String body;
  String picture;

  OnboardingPage({this.title = '', this.body = '', this.picture = ''});
}
