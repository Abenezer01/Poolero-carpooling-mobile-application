import 'package:carpooling_beta/app/Auth/presentation/components/static_widgets.dart';
import 'package:carpooling_beta/app/core/components/my_button.dart';
import 'package:carpooling_beta/app/core/components/my_text_field.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carpooling_beta/app/Auth/presentation/controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            // height: Get.height,
            child: Obx(
              () => Center(
                child: controller.isLoading.value
                    ? CircularProgressIndicator(color: AppTheme.primaryColor)
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/logo.png',
                              height: Get.height * 0.2,
                              fit: BoxFit.fill,
                            ),
                            Text(
                              'POOLERO',
                              style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontFamily: AppTheme.primaryFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 40),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Create Account',
                                style: TextStyle(
                                  color: AppTheme.naturalColor1,
                                  fontFamily: AppTheme.primaryFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    color: AppTheme.naturalColor2,
                                    fontFamily: AppTheme.primaryFont,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await Future.delayed(
                                          Duration(seconds: 1));
                                      Get.toNamed('/login');
                                    },
                                    child: Text(
                                      'Sign in!',
                                      style: TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontFamily: AppTheme.primaryFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Container(
                              child: Form(
                                key: controller.formKey,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: MyTextField(
                                                  inputType: TextInputType.name,
                                                  textController: controller
                                                      .firstNameController,
                                                  validator: (value) => controller
                                                      .firstNameLastNameValidation(
                                                          value),
                                                  labelText: 'First Name'),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: MyTextField(
                                                  inputType: TextInputType.name,
                                                  textController: controller
                                                      .lastNameController,
                                                  validator: (value) => controller
                                                      .firstNameLastNameValidation(
                                                          value),
                                                  labelText: 'Last Name'),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 25),
                                        MyTextField(
                                            inputType:
                                                TextInputType.emailAddress,
                                            textController:
                                                controller.emailController,
                                            validator: (value) => controller
                                                .emailValidation(value!),
                                            labelText: 'Email'),
                                        SizedBox(height: 25),
                                        MyTextField(
                                            textController:
                                                controller.password1Controller,
                                            validator: (value) =>
                                                controller.passwordValidation(
                                                    value!,
                                                    controller
                                                        .password2Controller
                                                        .text),
                                            labelText: 'Password',
                                            isPassword: true),
                                        SizedBox(height: 25),
                                        MyTextField(
                                            textController:
                                                controller.password2Controller,
                                            validator: (value) =>
                                                controller.passwordValidation(
                                                    value!,
                                                    controller
                                                        .password1Controller
                                                        .text),
                                            labelText: 'Confirm Password',
                                            isPassword: true),
                                        SizedBox(height: 25),
                                        MyTextField(
                                            inputType: TextInputType.phone,
                                            textController:
                                                controller.phoneController,
                                            validator: (value) => controller
                                                .phoneNumberValidation(value!),
                                            labelText: 'Phone Number'),
                                        SizedBox(height: 25),
                                        MyTextField(
                                            inputType: TextInputType.number,
                                            textController: controller
                                                .driverLicenseController,
                                            validator: (value) => controller
                                                .driverLicenseValidation(
                                                    value!),
                                            labelText: 'Driver License'),
                                      ],
                                    ),
                                    SizedBox(height: 35),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: MyButton(
                                            isPrimary: true,
                                            isDisabled: false,
                                            textTitle: 'Sign up',
                                            onPresse: () {
                                              controller.submitForm();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 25),
                                    OrDivider(),
                                    SizedBox(height: 25),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SocialMediaIcon(
                                          iconPath: 'assets/Google.png',
                                          onTap: () {},
                                        ),
                                        SizedBox(width: 30),
                                        SocialMediaIcon(
                                          iconPath: 'assets/Facebook.png',
                                          onTap: () {},
                                        ),
                                        SizedBox(width: 30),
                                        SocialMediaIcon(
                                          iconPath: 'assets/Twitter.png',
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
