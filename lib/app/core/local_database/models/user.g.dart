// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User()
      ..id = fields[0] as String
      ..firstName = fields[1] as String
      ..lastName = fields[2] as String
      ..email = fields[3] as String
      ..password = fields[4] as String
      ..username = fields[5] as String
      ..phoneNumber = fields[6] as String
      ..driverLicense = fields[7] as String
      ..profileImg = fields[8] as String
      ..token = fields[9] as String
      ..cars = (fields[10] as List?)?.cast<Car>()
      ..conversations = (fields[11] as List).cast<Message>();
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.username)
      ..writeByte(6)
      ..write(obj.phoneNumber)
      ..writeByte(7)
      ..write(obj.driverLicense)
      ..writeByte(8)
      ..write(obj.profileImg)
      ..writeByte(9)
      ..write(obj.token)
      ..writeByte(10)
      ..write(obj.cars)
      ..writeByte(11)
      ..write(obj.conversations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
