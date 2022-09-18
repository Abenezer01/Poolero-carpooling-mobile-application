import 'package:carpooling_beta/app/Chat/domain/entities/Message.dart';
import 'package:carpooling_beta/app/core/utils.dart';

class MessageModel extends Message {
  MessageModel({
    required super.idUser,
    required super.toUser,
    required super.urlAvatar,
    required super.username,
    required super.message,
    required super.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        idUser: json['idUser'],
        toUser: json['toUser'],
        urlAvatar: json['urlAvatar'],
        username: json['username'],
        message: json['message'],
        createdAt: ChatUtils.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'toUser': toUser,
        'urlAvatar': urlAvatar,
        'username': username,
        'message': message,
        'createdAt': ChatUtils.fromDateTimeToJson(createdAt),
      };
}
