import 'package:carpooling_beta/app/Chat/presentation/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carpooling_beta/app/core/theme.dart';

class MessageWidget extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: controller.isMe.value
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: <Widget>[
        if (!controller.isMe.value)
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage('assets/Rectangle.png'),
          ),
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          constraints: BoxConstraints(maxWidth: 140),
          decoration: BoxDecoration(
            color: controller.isMe.value
                ? AppTheme.primaryColor
                : AppTheme.primaryColor2,
            borderRadius: controller.isMe.value
                ? borderRadius.subtract(BorderRadius.only(bottomRight: radius))
                : borderRadius.subtract(BorderRadius.only(bottomLeft: radius)),
          ),
          child: buildMessage(),
        ),
      ],
    );
  }

  Widget buildMessage() => Column(
        crossAxisAlignment: controller.isMe.value
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            controller.message!.message,
            style: TextStyle(
                color: controller.isMe.value
                    ? Colors.white
                    : AppTheme.naturalColor2),
            textAlign: controller.isMe.value ? TextAlign.end : TextAlign.start,
          ),
        ],
      );
}
