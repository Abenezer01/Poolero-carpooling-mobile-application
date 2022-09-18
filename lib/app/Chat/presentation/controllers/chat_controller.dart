import 'package:carpooling_beta/app/Chat/data/models/message_model.dart';
import 'package:carpooling_beta/app/Chat/domain/entities/Message.dart';
import 'package:carpooling_beta/app/Chat/domain/usecases/get_messages_usecase.dart';
import 'package:carpooling_beta/app/Chat/domain/usecases/send_message_usecase.dart';
import 'package:carpooling_beta/app/Chat/domain/usecases/get_conversations_usecase.dart';
import 'package:carpooling_beta/app/Home/presentation/controllers/home_controller.dart';
import 'package:carpooling_beta/app/Profile/presentation/controllers/profile_controller.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:carpooling_beta/app/core/local_database/operations/user_operations.dart';
import 'package:carpooling_beta/app/core/services/service_locator.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxBool isLoading = false.obs;

  Stream<List<Message>>? messagesStream;
  RxList messages = [].obs;
  // RxList conversationsList = [].obs;
  Message? message;
  User? user;
  String? userTarget;
  RxBool isMe = true.obs;
  final messageTextController = TextEditingController();
  final listViewController = ScrollController();
  final homeController = Get.find<HomeController>();

  @override
  void onInit() async {
    super.onInit();

    user = await UserLocalDataBaseOperations().get();
    userTarget = Get.arguments['userTarget'];

    getMessages(user!.id, userTarget!);
    getConversations(user!.id);

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

    conversations.fold((l) {
      Get.snackbar(
        'Chat Error',
        l.message,
        backgroundColor: AppTheme.accentColor,
        colorText: AppTheme.naturalColor5,
      );
    }, (r) {
      print('CHATCONTROLLER:');
      homeController.myConversations.clear();
      homeController.myConversations.addAll(r);
      homeController.myConversations.refresh();
      print(homeController.myConversations);
    });
  }

  void getMessages(String fromUser, String toUser) async {
    final messagesList =
        await GetMessagesUseCase(serviceLocator())(fromUser, toUser);

    messagesList.fold((l) {
      Get.snackbar(
        'Chat Error',
        l.message,
        backgroundColor: AppTheme.accentColor,
        colorText: AppTheme.naturalColor5,
      );
    }, (r) {
      messages.bindStream(r);
      messages.refresh();
      animateListView();
    });
  }

  void sendMessage(String fromUser, String toUser, String message) async {
    print('sendMessage-controller: $fromUser - $fromUser');
    final newMessage =
        await SendMessageUseCase(serviceLocator())(fromUser, toUser, message);

    newMessage.fold((l) {
      print(l.message);
    }, (r) async {
      final message = MessageModel(
        idUser: r.idUser,
        toUser: r.toUser,
        urlAvatar: r.urlAvatar,
        username: r.username,
        message: r.message,
        createdAt: r.createdAt,
      );
      messages.insert(0, message);
      messages.refresh();
      messageTextController.clear();
      animateListView();
      // getConversations();

      homeController.myConversations.clear();
      homeController.myConversations.addAll(user!.conversations);
      homeController.myConversations.map((element) {
        if (element.toUser == toUser) {
          element = r;
        } else {
          homeController.myConversations.add(r);
        }
        homeController.myConversations.refresh();
        return;
      });
    });
  }

  void animateListView() {
    listViewController.animateTo(
      listViewController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
}
