import 'package:carpooling_beta/app/Home/presentation/components/static_widgets.dart';
import 'package:carpooling_beta/app/Home/presentation/components/ride_infos.dart';
import 'package:carpooling_beta/app/Home/presentation/components/ride_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carpooling_beta/app/Home/presentation/controllers/map_controller.dart';
import 'package:carpooling_beta/app/Home/presentation/components/google_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends GetView<MapController> {
  const MapView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              MyGoogleMap(),
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        // Back Action Button
                        MyActionButton(
                          toolTiptext: 'back',
                          onPressedCall: () => Get.back(),
                          icon: Icons.arrow_back_ios_rounded,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (controller.origin!.value.position !=
                                  LatLng(0.0, 0.0))
                                // Origin Action Button
                                MyActionButton(
                                  toolTiptext: 'origin',
                                  onPressedCall: () {
                                    MapController.googleMapController
                                        ?.animateCamera(
                                            CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                    target: controller
                                                        .origin!.value.position,
                                                    zoom: 17,
                                                    tilt: 50.0)));
                                    controller.focusOnMap.value = true;
                                  },
                                  icon: Icons.location_on,
                                ),
                              if (controller.destination!.value.position !=
                                  LatLng(0.0, 0.0))
                                // Destination Action Button
                                MyActionButton(
                                  toolTiptext: 'destination',
                                  onPressedCall: () async {
                                    await MapController.googleMapController
                                        ?.animateCamera(
                                            CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                    target: controller
                                                        .destination!
                                                        .value
                                                        .position,
                                                    zoom: 17,
                                                    tilt: 50.0)));
                                    controller.focusOnMap.value = true;
                                  },
                                  icon: Icons.location_searching_rounded,
                                ),
                              // Show Action Button
                              MyActionButton(
                                toolTiptext: 'show',
                                onPressedCall: () async {
                                  controller.updateMapToBounds(
                                      controller.getCurrentBounds(
                                    controller.origin!.value.position,
                                    controller.destination!.value.position,
                                  ));
                                  controller.focusOnMap.value =
                                      !controller.focusOnMap.value;
                                },
                                icon: controller.focusOnMap.value
                                    ? Icons.fullscreen_rounded
                                    : Icons.fullscreen_exit_rounded,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              controller.exploreRide.value ? RideInfos() : RideForm(),
            ],
          ),
        ),
      ),
    );
  }
}
