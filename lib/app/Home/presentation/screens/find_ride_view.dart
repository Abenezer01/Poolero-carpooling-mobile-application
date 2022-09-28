import 'package:carpooling_beta/app/Home/domain/entities/Ride.dart';
import 'package:carpooling_beta/app/Home/presentation/components/static_widgets.dart';
import 'package:carpooling_beta/app/Home/presentation/controllers/map_controller.dart';
import 'package:carpooling_beta/app/Home/presentation/controllers/payment_controller.dart';
import 'package:carpooling_beta/app/core/components/my_button.dart';
import 'package:carpooling_beta/app/core/constants.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindRideView extends GetView<MapController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Available Rides',
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
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(.08),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemCount: controller.ridesList.length,
              itemBuilder: (BuildContext context, int index) {
                Ride ride = controller.ridesList[index];
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
                        padding: const EdgeInsets.symmetric(vertical: 8),
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
                        info:
                            '${AppConstants.fromTime(ride.departureDate).hour}:${AppConstants.fromTime(ride.departureDate).minute}',
                        label: 'Begin at'),
                    TripInfo(
                        icon: 'assets/Clock1.png',
                        info:
                            '${AppConstants.fromTime(ride.endTime).hour}:${AppConstants.fromTime(ride.endTime).minute}',
                        label: 'End at'),
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
                          controller.RouteRide(ride);
                        }),
                    MyButton(
                      isPrimary: true,
                      isDisabled: !AppConstants.isAuth,
                      textTitle: 'Join us',
                      onPresse: () {
                        if (AppConstants.isAuth) {
                          controller.pay(
                              int.parse(controller
                                  .requestedSeatsController.value.text),
                              ride.totalCost,
                              ride);
                        }

                        // controller.CheckInRide(
                        //   rideId: controller.rides[index]['id'],
                        //   requestedSeats: requestedSeats,
                        // );
                      },
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
