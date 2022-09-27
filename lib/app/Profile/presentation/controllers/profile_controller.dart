import 'package:carpooling_beta/app/Profile/domain/entities/Car.dart';
import 'package:carpooling_beta/app/Profile/domain/entities/Profile.dart';
import 'package:carpooling_beta/app/Profile/domain/usecases/profile_usecase.dart';
import 'package:carpooling_beta/app/Profile/domain/usecases/update_profile_usecase.dart';
import 'package:carpooling_beta/app/core/error_handling/validation_error.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:carpooling_beta/app/core/services/service_locator.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isLoading = true.obs;
  RxList carsList = [].obs;
  User? user;
  Car? car;
  Profile? profile;
  late RxString username = ''.obs;
  late RxString userId = ''.obs;
  late TextEditingController firstNameController,
      lastNameController,
      emailController,
      usernameController,
      phoneNumberController,
      driverLicenceId;
  late GlobalKey<FormState> formKey;

  @override
  void onInit() async {
    super.onInit();
    // carController = Get.put<CarController>();

    getProfileInfos();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    driverLicenceId = TextEditingController();

    isLoading.value = false;
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      updateProfileInfos(
          userId.value,
          firstNameController.text,
          lastNameController.text,
          usernameController.text,
          emailController.text,
          phoneNumberController.text,
          driverLicenceId.text);
    }
  }

  String? firstNameLastNameUsernameValidation(value) {
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

  Future<void> updateProfileInfos(
      String id,
      String firstName,
      String lastName,
      String username,
      String email,
      String phoneNumber,
      String driverLicense) async {
    UpdateProfileUseCase(serviceLocator())(id, firstName, lastName, username,
            email, phoneNumber, driverLicense)
        .then((profile) {
      profile.fold((l) {
        Get.snackbar('Error occurred', l.message,
            backgroundColor: AppTheme.accentColor, colorText: Colors.white);
      }, (r) {
        Get.snackbar(
          'Profile',
          'Your profile was updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        );
        Get.toNamed('/profile');

        getProfileInfos();
      });
    });
  }

  Future<void> getProfileInfos() async {
    await ProfileUseCase(serviceLocator())().then((value) {
      value.fold((l) {
        print(l.message);
      }, (r) {
        profile = r;
        user = r.user;
        username.value = r.user.username;
        userId.value = r.user.id;
        carsList.clear();
        carsList.addAll(r.carsList!);

        firstNameController.text = user!.firstName;
        lastNameController.text = user!.lastName;
        usernameController.text = user!.username;
        emailController.text = user!.email;
        phoneNumberController.text = user!.phoneNumber;
        driverLicenceId.text = user!.driverLicense;
      });
    });
  }
}
