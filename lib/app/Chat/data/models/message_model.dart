import 'package:carpooling_beta/app/Chat/domain/entities/Message.dart';
import 'package:carpooling_beta/app/core/utils.dart';

class MessageModel extends Message {
  MessageModel({
    required super.idUser,
    required super.urlAvatar,
    required super.username,
    required super.message,
    required super.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        idUser: json['idUser'],
        urlAvatar: json['urlAvatar'],
        username: json['username'],
        message: json['message'],
        createdAt: ChatUtils.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'urlAvatar': urlAvatar,
        'username': username,
        'message': message,
        'createdAt': ChatUtils.fromDateTimeToJson(createdAt),
      };
}
