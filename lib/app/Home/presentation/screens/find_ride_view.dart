import 'package:carpooling_beta/app/Home/presentation/components/static_widgets.dart';
import 'package:carpooling_beta/app/Home/presentation/controllers/map_controller.dart';
import 'package:carpooling_beta/app/Home/presentation/controllers/payment_controller.dart';
import 'package:carpooling_beta/app/core/components/my_button.dart';
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
                              controller.ridesList[index].fromPlace.adresse +
                                  ', ' +
                                  controller.ridesList[index].fromPlace.city,
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
                              controller.ridesList[index].toPlace.adresse +
                                  ', ' +
                                  controller.ridesList[index].toPlace.city,
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
                        icon: 'assets/Clock.png', info: '16:30', label: 'Time'),
                    TripInfo(
                        icon: 'assets/Chat.png', info: '94%', label: 'Ontime'),
                    TripInfo(
                        icon: 'assets/Money.png', info: '56', label: 'Points'),
                  ],
                  buttons: [
                    MyButton(
                        isPrimary: false,
                        isDisabled: false,
                        textTitle: 'Route',
                        onPresse: () async {
                          // Get.to(RiderView(
                          //     fromPlace: rides[index]['fromPlace'],
                          //     toPlace: rides[index]['toPlace']));
                        }),
                    MyButton(
                      isPrimary: true,
                      isDisabled: false,
                      textTitle: 'Request Pay',
                      onPresse: () {
                        PaymentController payController = PaymentController();
                        payController.makePayment(amount: '5', currency: 'USD');
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
