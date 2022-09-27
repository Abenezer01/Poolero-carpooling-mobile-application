import 'package:carpooling_beta/app/Home/presentation/controllers/home_controller.dart';
import 'package:carpooling_beta/app/core/components/my_button.dart';
import 'package:carpooling_beta/app/core/components/trip_card.dart';
import 'package:carpooling_beta/app/core/components/trip_infos.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainPage extends GetWidget<HomeController> {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  clipBehavior: Clip.hardEdge,
                  height: 200.0,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                ),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          clipBehavior: Clip.antiAlias,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset(
                            'assets/image1.png',
                            fit: BoxFit.cover,
                          ));
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'New Rides For You',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AppTheme.naturalColor1,
                      fontFamily: AppTheme.primaryFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Obx(
                () => controller.ridesList.isEmpty
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        itemCount: controller.myRides.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TripCard(
                            avatarImg: 'assets/Avatar.png',
                            fullName: 'Bernard Alvarado',
                            description: '',
                            body: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Image.asset(
                                        'assets/Dot.png',
                                        height: 20,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${controller.myRides[index].fromPlace.adresse}, ${controller.myRides[index].fromPlace.city}',
                                        style: TextStyle(
                                          fontFamily: AppTheme.primaryFont,
                                          fontSize: 18,
                                          color: AppTheme.naturalColor1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 20,
                                        child: Image.asset(
                                          'assets/3 dots.png',
                                          height: 20,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Image.asset(
                                        'assets/pin-3.png',
                                        height: 20,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${controller.myRides.value[index].toPlace.adresse}, ${controller.myRides[index].toPlace.city}',
                                        style: TextStyle(
                                          fontFamily: AppTheme.primaryFont,
                                          fontSize: 18,
                                          color: AppTheme.naturalColor1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                            tripInfos: [
                              TripInfo(
                                  icon: 'assets/Clock.png',
                                  info: '16:30',
                                  label: 'Time'),
                              TripInfo(
                                  icon: 'assets/Chat.png',
                                  info: '94%',
                                  label: 'Ontime'),
                              TripInfo(
                                  icon: 'assets/Money.png',
                                  info: '56',
                                  label: 'Points'),
                            ],
                            buttons: [
                              MyButton(
                                  isPrimary: false,
                                  isDisabled: false,
                                  textTitle: 'Route',
                                  onPresse: () async {
                                    // Get.to(RiderView(
                                    //     fromPlace: controller.myRides[index]
                                    //         ['fromPlace'],
                                    //     toPlace: controller.myRides[index]
                                    //         ['toPlace']));
                                  }),
                              MyButton(
                                isPrimary: false,
                                isDisabled: false,
                                isDecline: true,
                                textTitle: 'Cancel',
                                onPresse: () {},
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
