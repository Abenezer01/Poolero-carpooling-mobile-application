import 'package:carpooling_beta/app/core/utils.dart';


class MessageField {
}

class Message {
  final String idUser;
  final String urlAvatar;
  final String username;
  String message;
  final DateTime createdAt;

  Message({
    required this.idUser,
    required this.urlAvatar,
    required this.username,
    required this.message,
    required this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
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
