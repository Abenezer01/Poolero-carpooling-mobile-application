import 'package:carpooling_beta/app/Chat/domain/entities/Message.dart';
import 'package:carpooling_beta/app/core/error_handling/http_error.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:carpooling_beta/app/core/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carpooling_beta/app/Chat/data/models/message_model.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseChatRemoteDataSource {
  Stream<List<MessageModel>> getMessages(String fromUserId, String toUserId);
  Future<Message> sendMessage(
      String fromUserId, String toUserId, String message);
  Future<List<User>> getConversations(String userId);
}

class ChatRemoteDataSource extends BaseChatRemoteDataSource {
  @override
  Stream<List<MessageModel>> getMessages(String fromUserId, String toUserId) {
    try {
      Stream sentMessages = FirebaseFirestore.instance
          .collection('chats/$fromUserId/messages/$toUserId/message')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .transform(ChatUtils.transformer(MessageModel.fromJson));

      Stream recievedMessages = FirebaseFirestore.instance
          .collection('chats/$toUserId/messages/$fromUserId/message')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .transform(ChatUtils.transformer(MessageModel.fromJson));

      return recievedMessages.zipWith(
          sentMessages, (recieved, sent) => recieved + sent);
    } on DioError catch (error) {
      debugPrint(error.toString());
      if (error.type == DioErrorType.connectTimeout) {
        throw HttpError.timeOut();
      } else {
        throw HttpError.serverError();
      }
    } on HttpError catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  @override
  Future<Message> sendMessage(
      String fromUserId, String toUserId, String message) async {
    try {
      final refMessages = FirebaseFirestore.instance
          .collection('chats/$fromUserId/messages/$toUserId/message');

      final newMessage = Message(
        idUser: toUserId,
        urlAvatar: 'myUrlAvatar',
        username: 'myUsername',
        message: message,
        createdAt: DateTime.now(),
      );

      // print('ChatRemoteDataSource');
      // print(newMessage);

      await refMessages.add(newMessage.toJson());
      return newMessage;
    } on DioError catch (error) {
      debugPrint(error.toString());
      if (error.type == DioErrorType.connectTimeout) {
        throw HttpError.timeOut();
      } else {
        throw HttpError.serverError();
      }
    } on HttpError catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  @override
  Future<List<User>> getConversations(String userId) async {
    try {
      List<User> users = [];
      final chatConversations = FirebaseFirestore.instance
          .collection('chats/fe98f549-e790-4e9f-aa16-18c2292a2ee9/messages/')
          .snapshots();

      print('ChatRemoteDataSource-getConversations');

      chatConversations.forEach((value) async {
        print('USERs-LENGTH: ${await chatConversations.length}');
        for (var element in value.docs) {
          print('USER IDs:');
          print(element.id);
        }
      });

      return users;
    } on DioError catch (error) {
      debugPrint(error.toString());
      if (error.type == DioErrorType.connectTimeout) {
        throw HttpError.timeOut();
      } else {
        throw HttpError.serverError();
      }
    } on HttpError catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }
}
