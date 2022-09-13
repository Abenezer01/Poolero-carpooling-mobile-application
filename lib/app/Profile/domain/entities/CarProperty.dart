import 'package:equatable/equatable.dart';

class CarProperty extends Equatable {
  String id;
  String name;

  CarProperty({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
