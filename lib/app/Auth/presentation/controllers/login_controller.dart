import 'package:carpooling_beta/app/Auth/domain/usecases/login_usecase.dart';
import 'package:carpooling_beta/app/Home/presentation/controllers/home_controller.dart';
import 'package:carpooling_beta/app/core/Notification.dart';
import 'package:carpooling_beta/app/core/error_handling/validation_error.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:carpooling_beta/app/core/notifications/notificationService.dart';
import 'package:carpooling_beta/app/core/services/service_locator.dart';
import 'package:carpooling_beta/app/core/notifications/notifications_config.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool rememberMe = false.obs;
  late TextEditingController emailController, passwordController;
  late GlobalKey<FormState> formKey;
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  Rx<GoogleSignInAccount>? currentUser;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    googleSignIn.signOut();

    googleSignIn.onCurrentUserChanged.listen((account) {
      if (currentUser != null) {
        currentUser!.value = account!;
      }
      print(account!.email);
      Get.offAndToNamed('/home', arguments: {
        "googleAuth": true,
        "user": User()
          ..id = account.id
          ..email = account.email
          ..username = account.displayName!,
      });
      Get.put(HomeController());
    });
    googleSignIn.signInSilently();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    isLoading.value = false;
  }

  @override
  void onClose() {
    super.onClose();
  }

  void doLogin(String email, String password) async {
    final loginUseCase = serviceLocator<LoginUseCase>();
    final user = await loginUseCase(email, password);
    user.fold(
        (l) => Get.snackbar(
              'Login Error',
              l.message,
              backgroundColor: AppTheme.accentColor,
              colorText: AppTheme.naturalColor5,
            ), (r) {
      Get.offAndToNamed('home', arguments: {'user': r});
      Get.put(HomeController);
    });
  }

  void submitForm() async {
    // sendNotification();
    if (formKey.currentState!.validate()) {
      doLogin(emailController.value.text, passwordController.value.text);
    }
  }

  String? emailValidation(value) {
    try {
      if (GetUtils.isNull(value) || GetUtils.isLengthEqualTo(value, 0)) {
        throw ValidationError.requiredField(message: 'Your Email is required!');
      } else if (!GetUtils.isEmail(value!)) {
        throw ValidationError.invalidField(message: 'Invalid Email!');
      }
      return null;
    } on ValidationError catch (e) {
      return e.message;
    }
  }

  String? passwordValidation(value) {
    try {
      if (GetUtils.isNull(value)) {
        throw ValidationError.requiredField(
            message: 'The password is required !');
      } else if (GetUtils.isLengthLessThan(value, 6)) {
        throw ValidationError.requiredField(
            message: 'The password should containe more than 6 characters !');
      }
      return null;
    } on ValidationError catch (e) {
      return e.message;
    }
  }
}
