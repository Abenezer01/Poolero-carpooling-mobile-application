import 'package:carpooling_beta/app/Home/presentation/components/static_widgets.dart';
import 'package:carpooling_beta/app/Home/presentation/controllers/map_controller.dart';
import 'package:carpooling_beta/app/core/constants.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideInfos extends GetWidget<MapController> {
  const RideInfos({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 0,
      left: 0,
      child: Obx(
        () => Visibility(
          visible: !controller.focusOnMap.value,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TripCard(
              avatarImg: 'assets/Avatar.png',
              fullName: controller.ride.driver.username,
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
                          '${controller.ride.fromPlace.adresse}, ${controller.ride.fromPlace.city}',
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
                          '${controller.ride.toPlace.adresse}, ${controller.ride.toPlace.city}',
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
                        '${AppConstants.fromTime(controller.ride.departureDate).hour}:${AppConstants.fromTime(controller.ride.endTime).minute}',
                    label: 'Time'),
                TripInfo(
                    icon: 'assets/send.png',
                    info: controller.ride.totalDistance.round().toString(),
                    label: 'KM'),
                TripInfo(
                    icon: 'assets/Money.png',
                    info: controller.ride.totalCost.round().toString(),
                    label: 'Dirhams'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
