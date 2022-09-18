import 'package:equatable/equatable.dart';
import 'package:carpooling_beta/app/Profile/domain/entities/Mark.dart';

class Model extends Equatable {
  String id;
  String name;
  Mark mark;

  Model({
    required this.id,
    required this.name,
    required this.mark,
  });

  @override
  List<Object?> get props => [id, name, mark];
}
