import 'package:carpooling_beta/app/Profile/presentation/controllers/profile_controller.dart';
import 'package:carpooling_beta/app/core/components/my_button.dart';
import 'package:carpooling_beta/app/core/components/my_text_field.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: AppTheme.naturalColor1,
            fontFamily: AppTheme.primaryFont,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppTheme.naturalColor1),
            onPressed: () => Get.back()),
        centerTitle: true,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(.08),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Obx(
            () => controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Image.asset('assets/Rectangle.png',
                                    fit: BoxFit.cover, width: 120),
                                SizedBox(height: 20),
                                Text(
                                  'Change Pictures',
                                  style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontFamily: AppTheme.primaryFont,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: MyTextField(
                                textController: controller.firstNameController,
                                labelText: 'First Name',
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              child: MyTextField(
                                  textController: controller.lastNameController,
                                  labelText: 'Last Name'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      MyTextField(
                        textController: controller.usernameController,
                        labelText: 'Username',
                      ),
                      SizedBox(height: 20),
                      MyTextField(
                        textController: controller.emailController,
                        labelText: 'Email',
                      ),
                      SizedBox(height: 20),
                      MyTextField(
                        textController: controller.phoneNumberController,
                        labelText: 'Phone Number',
                      ),
                      SizedBox(height: 30),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.09),
                              offset: Offset(0, 4),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text('Verified Profile'),
                            ),
                            Container(
                              child: Icon(Icons.check,
                                  color: AppTheme.primaryColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.09),
                              offset: Offset(0, 4),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text('Driver License'),
                            ),
                            Container(
                              child: controller.driverLicenceId.text != ''
                                  ? Icon(Icons.check,
                                      color: AppTheme.primaryColor)
                                  : Icon(Icons.close_rounded,
                                      color: AppTheme.accentColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: MyButton(
                                isPrimary: true,
                                isDisabled: false,
                                textTitle: 'Update Profile',
                                onPresse: () {
                                  controller.updateProfileInfos(
                                      controller.userId.value,
                                      controller.firstNameController.text,
                                      controller.lastNameController.text,
                                      controller.usernameController.text,
                                      controller.emailController.text,
                                      controller.phoneNumberController.text,
                                      controller.driverLicenceId.text);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class Badges extends StatelessWidget {
  final String title;
  final bool active;

  const Badges({
    Key? key,
    required this.title,
    this.active = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.all(
            color: active ? AppTheme.primaryColor : AppTheme.naturalColor3),
        color: active ? AppTheme.primaryColor : Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: active ? Colors.white : AppTheme.naturalColor3,
              fontFamily: AppTheme.primaryFont,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// class InputDate extends StatelessWidget {
//   final IconData icon;
//   final String inputText;
//   final TextInputType inputType;
//   final bool readOnly;
//   final VoidCallback? onTap;

//   const InputDate({
//     Key? key,
//     required this.icon,
//     this.inputText = '',
//     this.inputType = TextInputType.text,
//     this.readOnly = false,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Expanded(
//           child: MyTextField(
//               labelText: inputText,
//               inputType: inputType,
//               readOnly: readOnly,
//               onTap: onTap),
//         ),
//         Icon(icon, size: 20),
//       ],
//     );
//   }
// }
