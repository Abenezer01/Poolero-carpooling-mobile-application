import 'package:carpooling_beta/app/Chat/presentation/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carpooling_beta/app/core/theme.dart';

class NewMessageWidget extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: TextField(
                  controller: controller.messageTextController,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  cursorColor: AppTheme.primaryColor,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: AppTheme.primaryColor,
                    hoverColor: AppTheme.primaryColor,
                    labelStyle: TextStyle(color: AppTheme.primaryColor),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: AppTheme.primaryColor),
                      gapPadding: 10,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelText: 'Type your message',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0),
                      gapPadding: 10,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onChanged: (value) {
                    // controller.message = Message(
                    //     idUser: controller.user!.idUser!,
                    //     urlAvatar: controller.user!.urlAvatar,
                    //     username: controller.user!.name,
                    //     message: value,
                    //     createdAt: DateTime.now());
                    // // controller.message!.message = value;
                    // controller.isMe.value = true;
                  },
                ),
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                controller.message == null ||
                        controller.message!.message.trim().isEmpty
                    ? null
                    : controller.sendMessage(
                        controller.userTarget!,
                        controller.user!,
                        controller.messageTextController.value.text);
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryColor,
                ),
                child: Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      );
}
