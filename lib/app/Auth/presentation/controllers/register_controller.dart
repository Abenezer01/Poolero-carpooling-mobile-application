import 'package:carpooling_beta/app/Auth/data/datasource/auth_remote_datasource.dart';
import 'package:carpooling_beta/app/Auth/data/repository/auth_repository.dart';
import 'package:carpooling_beta/app/Auth/domain/entities/User.dart';
import 'package:carpooling_beta/app/Auth/domain/repository/base_auth_repository.dart';
import 'package:carpooling_beta/app/Auth/domain/usecases/register_usecase.dart';
import 'package:carpooling_beta/app/core/error_handling/validation_error.dart';
import 'package:carpooling_beta/app/core/services/service_locator.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  late GlobalKey<FormState> formKey;
  late TextEditingController firstNameController,
      lastNameController,
      emailController,
      password1Controller,
      password2Controller,
      phoneController,
      driverLicenseController;

  @override
  void onInit() {
    super.onInit();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    password1Controller = TextEditingController();
    password2Controller = TextEditingController();
    phoneController = TextEditingController();
    driverLicenseController = TextEditingController();
    // formKey = GlobalKey<FormState>();
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

  void doSignup(String firstName, String lastName, String email,
      String password1, String phoneNumber, String driverLicense) async {
    final username = '$firstName$lastName';
    User user = User(
      firstName: firstName,
      lastName: lastName,
      email: email,
      username: username,
      phoneNumber: phoneNumber,
      driverLicense: driverLicense,
    );

    final registerUseCase = serviceLocator<RegisterUseCase>();
    final registeredUser = await registerUseCase(user);
    registeredUser.fold(
        (l) => Get.snackbar(
              'Login Error',
              l.message,
              backgroundColor: AppTheme.accentColor,
              colorText: AppTheme.naturalColor5,
            ),
        (r) => Get.offAndToNamed('register', arguments: {'user': user}));
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      doSignup(
        firstNameController.value.text,
        lastNameController.value.text,
        emailController.value.text,
        password1Controller.value.text,
        phoneController.value.text,
        driverLicenseController.value.text,
      );
    }
  }

  String? firstNameLastNameValidation(value) {
    try {
      if (GetUtils.isNull(value) || GetUtils.isLengthEqualTo(value, 0)) {
        throw ValidationError.requiredField(message: 'Your Name is required!');
      }
      return null;
    } on ValidationError catch (e) {
      return e.message;
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

  String? passwordValidation(value1, value2) {
    try {
      if (GetUtils.isNull(value1)) {
        throw ValidationError.requiredField(
            message: 'The password is required !');
      } else if (GetUtils.isLengthLessThan(value1, 6)) {
        throw ValidationError.requiredField(
            message: 'The password should containe more than 6 characters !');
      } else if (GetUtils.isEqual(value1, value2)) {
        throw ValidationError.fieldsDoNotMatch(
            message: 'Passwords Do Not Match !');
      }
      return null;
    } on ValidationError catch (e) {
      return e.message;
    }
  }

  String? phoneNumberValidation(value) {
    try {
      if (GetUtils.isPhoneNumber(value)) {
        throw ValidationError.fieldsDoNotMatch(
            message: 'Invalid Phone Number!');
      }
      return null;
    } on ValidationError catch (e) {
      return e.message;
    }
  }

  String? driverLicenseValidation(value) {
    try {
      if (GetUtils.isLengthLessThan(value, 6)) {
        throw ValidationError.minimumLength(
            message:
                'The driver license should containe more than 6 numbers !');
      }
      return null;
    } on ValidationError catch (e) {
      return e.message;
    }
  }
}
