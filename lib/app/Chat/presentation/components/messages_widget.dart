import 'package:carpooling_beta/app/Chat/domain/entities/Message.dart';
import 'package:carpooling_beta/app/Chat/presentation/controllers/chat_controller.dart';
import 'package:carpooling_beta/app/Chat/presentation/components/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesWidget extends GetView<ChatController> {
  const MessagesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => controller.messages.isEmpty
            ? Container(
                height: Get.height,
                width: Get.width,
                child: Center(
                  child: Text('Start a conversation..'),
                ),
              )
            : ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                reverse: true,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  // if (controller.message == null) {
                  //   return SizedBox();
                  // }
                  controller.message = controller.messages[index];
                  print(
                      'PRINTING MSGS: ${controller.message!.message} - ISME: ${controller.isMe.value} - ${controller.message!.username} ${controller.message!.createdAt}');

                  controller.isMe.value =
                      (controller.message!.idUser == controller.user);
                  print('ISME: ${controller.isMe.value}');
                  return MessageWidget();
                },
              ),
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}
