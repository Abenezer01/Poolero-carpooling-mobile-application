import 'dart:convert';

import 'package:carpooling_beta/app/core/components/my_button.dart';
import 'package:carpooling_beta/app/core/components/my_text_field.dart';
import 'package:carpooling_beta/app/Auth/presentation/components/static_widgets.dart';
import 'package:carpooling_beta/app/core/constants.dart';
import 'package:carpooling_beta/app/core/error_handling/validation_error.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carpooling_beta/app/Auth/presentation/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: Get.height + Get.statusBarHeight,
            child: Obx(
              () => Container(
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
                                'Welcome Back!',
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
                                  "Don't have an account?",
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
                                          Duration(milliseconds: 50));
                                      Get.offAndToNamed('/register');
                                    },
                                    child: Text(
                                      'Sign up now!',
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
                              child: Expanded(
                                child: Form(
                                  key: controller.formKey,
                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      MyTextField(
                                        textController:
                                            controller.emailController,
                                        labelText: 'Your Email',
                                        validator: (value) =>
                                            controller.emailValidation(value),
                                      ),
                                      SizedBox(height: 25),
                                      MyTextField(
                                        textController:
                                            controller.passwordController,
                                        validator: (value) => controller
                                            .passwordValidation(value),
                                        labelText: 'Your Password',
                                        isPassword: true,
                                      ),
                                      SizedBox(height: 25),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: SizedBox(
                                                  height: 10,
                                                  width: 10,
                                                  child: Checkbox(
                                                    value: controller
                                                        .rememberMe.value,
                                                    onChanged: (val) =>
                                                        controller.rememberMe
                                                            .value = val!,
                                                    activeColor:
                                                        AppTheme.primaryColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'Remember me',
                                                style: TextStyle(
                                                  color: AppTheme.naturalColor4,
                                                  fontFamily:
                                                      AppTheme.primaryFont,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {},
                                                child: Text(
                                                  'Forgot Password?',
                                                  style: TextStyle(
                                                    color:
                                                        AppTheme.naturalColor3,
                                                    fontFamily:
                                                        AppTheme.primaryFont,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 25),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: MyButton(
                                                isPrimary: true,
                                                isDisabled: false,
                                                textTitle: 'Sign in',
                                                onPresse: () {
                                                  controller.submitForm();
                                                }),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      OrDivider(),
                                      SizedBox(height: 20),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.center,
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.center,
                                      //   children: [
                                      //     SocialMediaIcon(
                                      //       iconPath: 'assets/Google.png',
                                      //       onTap: () {
                                      //         try {
                                      //           // controller.googleSignIn.signIn();
                                      //         } catch (e) {
                                      //           print(e);
                                      //         }
                                      //       },
                                      //     ),
                                      //     SizedBox(width: 30),
                                      //     SocialMediaIcon(
                                      //       iconPath: 'assets/Facebook.png',
                                      //       onTap: () {},
                                      //     ),
                                      //     SizedBox(width: 30),
                                      //     SocialMediaIcon(
                                      //       iconPath: 'assets/Twitter.png',
                                      //       onTap: () {},
                                      //     ),
                                      //   ],
                                      // ),
                                      // SizedBox(height: 20),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    border: Border.all(
                                                        color: AppTheme
                                                            .primaryColor,
                                                        width: 1.5),
                                                  ),
                                                  child: TextButton.icon(
                                                    onPressed: () {
                                                      print('googleSignIn');
                                                      controller.googleSignIn
                                                          .signIn();
                                                    },
                                                    icon: Image.asset(
                                                      'assets/google_icon.png',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    label: Text(
                                                      'Sign in with Google',
                                                      style: TextStyle(
                                                        color: AppTheme
                                                            .primaryColor,
                                                        fontFamily: AppTheme
                                                            .primaryFont,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    border: Border.all(
                                                        color: AppTheme
                                                            .primaryColor,
                                                        width: 1.5),
                                                  ),
                                                  child: TextButton.icon(
                                                    onPressed: () {
                                                      AppConstants.isAuth =
                                                          false;
                                                      Get.toNamed('/map');
                                                    },
                                                    icon: Image.asset(
                                                      'assets/guest.png',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    label: Text(
                                                      'Continue as guest',
                                                      style: TextStyle(
                                                        color: AppTheme
                                                            .primaryColor,
                                                        fontFamily: AppTheme
                                                            .primaryFont,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
