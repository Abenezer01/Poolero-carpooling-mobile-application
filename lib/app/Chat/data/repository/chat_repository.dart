import 'package:carpooling_beta/app/Chat/data/datasource/Chat_remote_datasource.dart';
import 'package:carpooling_beta/app/Chat/domain/entities/Message.dart';
import 'package:carpooling_beta/app/Chat/domain/repository/base_chat_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:dartz/dartz.dart';

class ChatRepository extends BaseChatRepository {
  final BaseChatRemoteDataSource baseChatRemoteDataSource;

  ChatRepository(this.baseChatRemoteDataSource);

  @override
  Future<Either<DomainError, Stream<List<Message>>>> getMessagesRepo(
      fromUserId, toUserId) async {
    try {
      final messages =
          await baseChatRemoteDataSource.getMessages(fromUserId, toUserId);
      return Right(messages);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }

  @override
  Future<Either<DomainError, Message>> sendMessageRepo(
      fromUserId, toUserId, message) async {
    try {
      final newMessage = await baseChatRemoteDataSource.sendMessage(
          fromUserId, toUserId, message);
      print('sendMessageRepo');
      print(newMessage);
      return Right(newMessage);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }

  
  @override
  Future<Either<DomainError, List<User>>> chatConversationsRepo(userId) async {
    try {
      final conversations = await baseChatRemoteDataSource.getConversations(
          userId);
      print('chatConversationsRepo');
      print(conversations);
      return Right(conversations);
    } on DomainError catch (e) {
      print(e.message);
      return Left(e);
    }
  }
}
