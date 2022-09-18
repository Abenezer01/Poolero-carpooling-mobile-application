import 'package:equatable/equatable.dart';

class CarProperty extends Equatable {
  String id;
  String name;
  String? mark;

  CarProperty({
    required this.id,
    required this.name,
    this.mark,
  });

  @override
  List<Object?> get props => [id, name];
}
