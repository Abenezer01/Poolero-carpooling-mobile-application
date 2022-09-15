import 'package:equatable/equatable.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions extends Equatable {
  final LatLngBounds? bounds;
  List<PointLatLng>? polylinePoints;
  final String? totalDistance;
  final String? totalDuration;

  Directions({
    this.bounds,
    this.polylinePoints,
    this.totalDistance,
    this.totalDuration,
  });


  
  factory Directions.fromMap(Map<String, dynamic> map) {
    //Check if route is not available
    // if ((map['routes'] as List).isEmpty) {
    //   return null;
    // }

    //Get route informations
    final data = Map<String, dynamic>.from(map['routes'][0]);

    //Bounds
    final notheast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
      northeast: LatLng(notheast['lat'], notheast['lng']),
      southwest: LatLng(southwest['lat'], southwest['lng']),
    );

    // Distance & Duration
    String distance = '';
    String duration = '';
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }

    return Directions(
      bounds: bounds,
      polylinePoints:
          PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistance: distance,
      totalDuration: duration,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        bounds,
        polylinePoints,
        totalDistance,
        totalDuration,
      ];
}
