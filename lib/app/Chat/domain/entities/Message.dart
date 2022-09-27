import 'package:carpooling_beta/app/core/utils.dart';


class MessageField {
}

class Message {
   String idUser;
   String toUser;
   String urlAvatar;
   String username;
  String message;
   DateTime createdAt;

  Message({
    required this.idUser,
    required this.toUser,
    required this.urlAvatar,
    required this.username,
    required this.message,
    required this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
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
