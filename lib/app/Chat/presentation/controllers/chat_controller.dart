import 'package:carpooling_beta/app/Auth/domain/entities/User.dart';
import 'package:carpooling_beta/app/Chat/data/models/message_model.dart';
import 'package:carpooling_beta/app/Chat/domain/entities/Message.dart';
import 'package:carpooling_beta/app/Chat/domain/usecases/get_messages_usecase.dart';
import 'package:carpooling_beta/app/Chat/domain/usecases/send_message_usecase.dart';
import 'package:carpooling_beta/app/Chat/domain/usecases/get_conversations_usecase.dart';
import 'package:carpooling_beta/app/Profile/presentation/controllers/profile_controller.dart';
import 'package:carpooling_beta/app/core/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxBool isLoading = false.obs;

  Stream<List<Message>>? messagesStream;
  RxList messages = [].obs;
  Message? message;
  String? user;
  String? userTarget;
  RxBool isMe = true.obs;
  final messageTextController = TextEditingController();
  final listViewController = ScrollController();

  @override
  void onInit() async {
    super.onInit();

    final profileController = Get.find<ProfileController>();

    user = profileController.userId.value;
    userTarget = Get.arguments['userTarget'];
    print('userTarget:');
    print(Get.arguments['userTarget']);
    // user = 'fe98f549-e790-4e9f-aa16-18c2292a2ee9';
    // userTarget = 'cc4b6ecc-0523-49a7-a4de-18c8cff17541';

    getMessages(user!, userTarget!);

    getConversations(user!);

    isLoading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getConversations(String userId) async {
    final conversations =
        await GetConversationsUseCase(serviceLocator())(userId);
  }

  void getMessages(String fromUser, String toUser) async {
    final messagesList =
        await GetMessagesUseCase(serviceLocator())(fromUser, toUser);

    messagesList.fold((l) {
      print(l.message);
    }, (r) {
      messages.bindStream(r);
      messages.refresh();
      // print('----MESSAGES----');
      // for (Message msg in messages) {
      //   print('Message');
      //   print(msg.message);
      // }
    });
  }

  void sendMessage(String fromUser, String toUser, String message) async {
    final newMessage =
        await SendMessageUseCase(serviceLocator())(fromUser, toUser, message);

    newMessage.fold((l) {
      print(l.message);
    }, (r) {
      messages.insert(
          0,
          MessageModel(
              idUser: r.idUser,
              urlAvatar: r.urlAvatar,
              username: r.username,
              message: r.message,
              createdAt: r.createdAt));
      messages.refresh();
      messageTextController.clear();
      listViewController.animateTo(
        listViewController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
      // print('----MESSAGES----');
      // for (Message msg in messages) {
      //   print('Message');
      //   print(msg.message);
      // }
    });
  }
}
