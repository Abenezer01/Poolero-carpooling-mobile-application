import 'package:carpooling_beta/app/Chat/data/models/message_model.dart';
import 'package:carpooling_beta/app/Chat/domain/entities/Message.dart';
import 'package:carpooling_beta/app/Chat/domain/usecases/get_messages_usecase.dart';
import 'package:carpooling_beta/app/Chat/domain/usecases/send_message_usecase.dart';
import 'package:carpooling_beta/app/Home/presentation/controllers/home_controller.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:carpooling_beta/app/core/local_database/operations/user_operations.dart';
import 'package:carpooling_beta/app/core/services/service_locator.dart';
import 'package:carpooling_beta/app/core/theme.dart';
import 'package:carpooling_beta/app/core/utils.dart';
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
  User? userTarget;
  RxBool isMe = true.obs;
  final messageTextController = TextEditingController();
  final listViewController = ScrollController();
  final homeController = Get.find<HomeController>();

  @override
  void onInit() async {
    super.onInit();

    user = await UserLocalDataBaseOperations().get();
    userTarget = await getUserInfos(Get.arguments['userTarget']);

    getMessages(user!.id, userTarget!.id);

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

  void sendMessage(String fromUser, String toUser, String messageText) async {
    final newMessageObj = Message(
      idUser: fromUser,
      toUser: toUser,
      message: messageText,
      urlAvatar: userTarget!.profileImg,
      username: userTarget!.username,
      createdAt: ChatUtils.fromDateTimeToJson(DateTime.now()),
    );
    final newMessage =
        await SendMessageUseCase(serviceLocator())(newMessageObj);

    newMessage.fold((l) {
      print(l.message);
    }, (r) async {
      final message = MessageModel(
        idUser: r.idUser,
        toUser: r.toUser,
        urlAvatar: userTarget!.profileImg,
        username: userTarget!.username,
        message: r.message,
        createdAt: r.createdAt,
      );
      messages.insert(0, message);
      messages.refresh();
      messageTextController.clear();
      animateListView();
    });
  }

  Future<User> getUserInfos(String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) {
      return User()
        ..id = value.get('userId')
        ..username = value.get('username')
        ..profileImg = value.get('urlAvatar');
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
