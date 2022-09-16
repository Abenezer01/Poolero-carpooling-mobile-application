import 'package:carpooling_beta/app/Chat/presentation/controllers/chat_controller.dart';
import 'package:carpooling_beta/app/Chat/presentation/components/messages_widget.dart';
import 'package:carpooling_beta/app/Chat/presentation/components/new_message_widget.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatView extends GetWidget<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Chat Room',
          style: TextStyle(
            color: AppTheme.naturalColor1,
            fontFamily: AppTheme.primaryFont,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppTheme.naturalColor1,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.black.withOpacity(.2),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: controller.listViewController,
                  physics: ScrollPhysics(),
                  child: MessagesWidget(),
                ),
              ),
            ),
            NewMessageWidget(),
          ],
        ),
      ),
    );
  }
}
