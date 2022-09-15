import 'package:carpooling_beta/app/Profile/presentation/controllers/profile_controller.dart';
import 'package:carpooling_beta/app/core/components/my_button.dart';
import 'package:carpooling_beta/app/core/local_database/operations/user_operations.dart';
import 'package:carpooling_beta/app/core/services/service_locator.dart';
import 'package:carpooling_beta/app/Home/domain/usecases/rides_usecase.dart';
import 'package:carpooling_beta/app/Home/domain/usecases/checkings_usecase.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  late final AdvancedDrawerController advancedDrawerController;
  RxString username = ''.obs;
  RxString token = ''.obs;
  RxString userId = ''.obs;
  late final TabController tabController =
      TabController(vsync: this, length: 4);
  RxString pageId = 'Home'.obs;
  late final RxList<dynamic> myRides = [].obs;
  late final RxList<dynamic> myCheckings = [].obs;
  RxString checkingId = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    Get.lazyPut(() => ProfileController());
    advancedDrawerController = AdvancedDrawerController();

    ProfileController profileController = Get.find<ProfileController>();
    profileController.getProfileInfos().then((value) {
      final user = profileController.user;
      // final user = await UserLocalDataBaseOperations().get();
      username.value = user.username;
      token.value = user.token;
      userId.value = user.id;
    });

    final myRidesList = await RidesUseCase(serviceLocator())(userId.value);
    myRidesList.fold((l) {
      Get.snackbar('Error occurred', l.message);
    }, (r) {
      print(r);
      myRides.addAll(r);
    });

    final myCheckingsList =
        await CheckingsUseCase(serviceLocator())(userId.value);
    myCheckingsList.fold((l) {
      Get.snackbar('Error occurred', l.message);
    }, (r) {
      print(r);
      myCheckings.addAll(r);
    });
    isLoading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void questionDialog() => Get.defaultDialog(
        title: '',
        titlePadding: EdgeInsets.all(0),
        content: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Image.asset('assets/ask.png', height: 120),
                SizedBox(height: 20),
                Text(
                  'Question',
                  style: TextStyle(
                    color: AppTheme.naturalColor1,
                    fontFamily: AppTheme.primaryFont,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Are You Confirm?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.naturalColor4,
                    fontFamily: AppTheme.primaryFont,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: MyButton(
                        isPrimary: false,
                        isDisabled: false,
                        isDecline: true,
                        textTitle: 'Cancel',
                        onPresse: () => Get.close(1),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: MyButton(
                        isPrimary: true,
                        isDisabled: false,
                        textTitle: 'Confirm',
                        onPresse: () => cancelChecking(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  void cancelChecking() async {
    print("CHEKING ID: ${checkingId.value}");
    // http.Response response =
    //     await rideProvider.cancelChecking(checkingId.value);
    // if (response.statusCode == 200) {
    //   successDialog();
    // }
    Get.toNamed('/home');
  }
}
