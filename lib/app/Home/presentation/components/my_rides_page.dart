import 'package:carpooling_beta/app/Home/domain/entities/Place.dart';
import 'package:carpooling_beta/app/Home/domain/entities/Ride.dart';
import 'package:carpooling_beta/app/Home/presentation/controllers/home_controller.dart';
import 'package:carpooling_beta/app/core/components/my_button.dart';
import 'package:carpooling_beta/app/core/components/trip_card.dart';
import 'package:carpooling_beta/app/core/components/trip_infos.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class MyRidesPage extends GetWidget<HomeController> {
  const MyRidesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Obx(
              () => !controller.isLoading.value && controller.myRides.isNotEmpty
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      itemCount: controller.myRides.length,
                      itemBuilder: (BuildContext context, int index) {
                        Ride ride = controller.myRides[index];
                        DateTime time = DateFormat("yyyy-MM-ddTHH:mm:ssZ")
                            .parse(ride.departureDate);
                        return TripCard(
                          avatarImg: 'assets/Avatar.png',
                          fullName: ride.driver.username,
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
                                      '${ride.fromPlace.adresse}, ${ride.fromPlace.city}',
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
                                      '${ride.toPlace.adresse}, ${ride.toPlace.city}',
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
                                info: '${time.hour}:${time.minute}',
                                label: 'Time'),
                            TripInfo(
                                icon: 'assets/send.png',
                                info: ride.totalDistance.round().toString(),
                                label: 'KM'),
                            TripInfo(
                                icon: 'assets/Money.png',
                                info: ride.totalCost.round().toString(),
                                label: 'Dirhams'),
                          ],
                          buttons: [
                            MyButton(
                                isPrimary: false,
                                isDisabled: false,
                                textTitle: 'Route',
                                onPresse: () async {
                                  Get.toNamed('/map', arguments: {
                                    'route': true,
                                      'ride': ride,
                                  });
                                }),
                            MyButton(
                              isPrimary: false,
                              isDisabled: false,
                              isDecline: true,
                              textTitle: 'Cancel',
                              onPresse: () {
                                controller.checkingId.value =
                                    controller.myCheckings[index].id;
                                controller.questionDialog();
                              },
                            ),
                          ],
                        );
                      })
                  : Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
