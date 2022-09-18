import 'package:carpooling_beta/app/Profile/domain/entities/Car.dart';
import 'package:carpooling_beta/app/Profile/domain/entities/CarProperty.dart';
import 'package:carpooling_beta/app/Profile/presentation/controllers/car_controller.dart';
import 'package:carpooling_beta/app/Profile/presentation/controllers/profile_controller.dart';
import 'package:carpooling_beta/app/Profile/presentation/components/car_card.dart';
import 'package:carpooling_beta/app/Profile/presentation/screens/car_view.dart';
import 'package:carpooling_beta/app/Profile/presentation/screens/edit_profile_view.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: AppTheme.naturalColor1,
            fontFamily: AppTheme.primaryFont,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppTheme.naturalColor1,
          ),
          onPressed: () => Get.toNamed('/home'),
        ),
        centerTitle: true,
        elevation: 0,
        // shadowColor: Colors.black.withOpacity(.08),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              constraints: BoxConstraints(minHeight: Get.height - 50),
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.09),
                    offset: Offset(0, -4),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    height: 60,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: -40,
                          child: Image.asset('assets/Rectangle.png'),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor2,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () => Get.to(() => EditProfileView()),
                          icon: Icon(
                            Icons.edit_outlined,
                            color: AppTheme.primaryColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Text(
                      controller.username.value,
                      style: TextStyle(
                        color: AppTheme.naturalColor1,
                        fontFamily: AppTheme.primaryFont,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Verified Profile',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontFamily: AppTheme.primaryFont,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            '1,260',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.naturalColor2,
                              fontFamily: AppTheme.primaryFont,
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            'total ride',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.naturalColor3,
                              fontFamily: AppTheme.primaryFont,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '414',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.naturalColor2,
                              fontFamily: AppTheme.primaryFont,
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            'as rider',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.naturalColor3,
                              fontFamily: AppTheme.primaryFont,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '846',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.naturalColor2,
                              fontFamily: AppTheme.primaryFont,
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            'as passenger',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.naturalColor3,
                              fontFamily: AppTheme.primaryFont,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: AppTheme.semanticColor2,
                                size: 24,
                              ),
                              Column(
                                children: [
                                  Text(
                                    '4.8',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppTheme.naturalColor1,
                                      fontFamily: AppTheme.primaryFont,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '(296)',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: AppTheme.naturalColor4,
                                      fontFamily: AppTheme.primaryFont,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.chat_bubble,
                                  color: AppTheme.semanticColor2, size: 24),
                              SizedBox(width: 5),
                              Column(
                                children: [
                                  Text(
                                    '95%',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppTheme.naturalColor1,
                                      fontFamily: AppTheme.primaryFont,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Ontime',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: AppTheme.naturalColor4,
                                      fontFamily: AppTheme.primaryFont,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Obx(
                    () => Container(
                      child: GridView.builder(
                          itemCount: controller.carsList.length + 1,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            if (index == controller.carsList.length) {
                              return CarCard(
                                  image: 'assets/Add button.png',
                                  onTap: () {
                                    Car car = Car(
                                      id: '',
                                      plaque: '',
                                      category: CarProperty(id: '', name: ''),
                                      color: CarProperty(id: '', name: ''),
                                      model: CarProperty(id: '', name: ''),
                                      mark: CarProperty(id: '', name: ''),
                                      modelYear: '',
                                      userId: controller.userId.value,
                                    );

                                    Get.toNamed(
                                      '/car',
                                      arguments: {
                                        'addCar': true,
                                        'userId': controller.userId.value,
                                        'car': car,
                                      },
                                    )!
                                        .then((value) {
                                      Get.find<CarController>();
                                    });
                                  });
                            }
                            return CarCard(
                              car: controller.carsList[index],
                              image: 'assets/Body Type.png',
                              onTap: () {
                                Get.toNamed(
                                  '/car',
                                  arguments: {
                                    'addCar': false,
                                    'userId': controller.userId.value,
                                    'car': controller.carsList[index],
                                  },
                                )!
                                    .then((value) {
                                  Get.find<CarController>();
                                });
                              },
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
