import 'package:carpooling_beta/app/Home/presentation/controllers/map_controller.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyGoogleMap extends GetWidget<MapController> {
  const MyGoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GoogleMap(
        onTap: (latLng) {
          controller.focusOnMap.value = true;
        },
        initialCameraPosition: controller.initialCameraPosition,
        zoomControlsEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (mapController) =>
            MapController.googleMapController = mapController,
        markers: {
          controller.origin!.value,
          controller.destination!.value,
        },
        polylines: {
          if (controller.directions != null &&
              controller.directions!.value.polylinePoints != null)
            Polyline(
              polylineId: const PolylineId('overview_polyline'),
              color: AppTheme.primaryColor,
              width: 5,
              points: controller.directions!.value.polylinePoints!
                  .map(
                    (e) => LatLng(e.latitude, e.longitude),
                  )
                  .toList(),
            ),
        },
      ),
    );
  }
}
