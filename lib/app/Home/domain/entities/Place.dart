import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final String id;
  final String city;
  final String adresse;
  final double latitude;
  final double longitude;

  Place({
    this.id='',
    required this.city,
    required this.adresse,
    required this.latitude,
    required this.longitude,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        city,
        adresse,
        latitude,
        longitude,
      ];
}
