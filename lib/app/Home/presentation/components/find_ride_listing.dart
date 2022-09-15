import 'package:carpooling_beta/app/Home/presentation/controllers/map_controller.dart';
import 'package:carpooling_beta/app/core/components/my_button.dart';
import 'package:carpooling_beta/app/core/components/trip_card.dart';
import 'package:carpooling_beta/app/core/components/trip_infos.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindRideView extends GetView<MapController> {
  late dynamic rides;
  late int requestedSeats;

  FindRideView({required this.rides, required this.requestedSeats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemCount: rides.length,
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
                              rides[index].fromPlace.adresse +
                                  ', ' +
                                  rides[index].fromPlace.city,
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
                              rides[index].toPlace.adresse +
                                  ', ' +
                                  rides[index].toPlace.city,
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
                          // Marker? origin = Marker(
                          //     markerId: const MarkerId('origin'),
                          //     infoWindow: const InfoWindow(title: 'origin'),
                          //     icon: BitmapDescriptor.defaultMarkerWithHue(
                          //         BitmapDescriptor.hueViolet),
                          //     position: LatLng(
                          //         rides[index]['fromPlace']['latitude'],
                          //         rides[index]['fromPlace']['longitude']));
                          // Marker? destination = Marker(
                          //     markerId: const MarkerId('destination'),
                          //     infoWindow:
                          //         const InfoWindow(title: 'destination'),
                          //     icon: BitmapDescriptor.defaultMarkerWithHue(
                          //         BitmapDescriptor.hueGreen),
                          //     position: LatLng(
                          //         rides[index]['toPlace']['latitude'],
                          //         rides[index]['toPlace']['longitude']));
                          Get.toNamed('/map', arguments: {
                            'fromPlace': rides[index]['fromPlace'],
                            'toPlace': rides[index]['toPlace']
                          });
                        }),
                    MyButton(
                      isPrimary: true,
                      isDisabled: false,
                      textTitle: 'Request',
                      onPresse: () {
                        controller.CheckInRide(
                          rideId: rides[index]['id'],
                          requestedSeats: requestedSeats,
                        );
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
