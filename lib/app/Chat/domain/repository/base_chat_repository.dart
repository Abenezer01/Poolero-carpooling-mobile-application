import 'package:carpooling_beta/app/Chat/domain/entities/Message.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:dartz/dartz.dart';

abstract class BaseChatRepository {
  Future<Either<DomainError, Stream<List<Message>>>> getMessagesRepo(
      fromUserId, toUserId);
  Future<Either<DomainError, Message>> sendMessageRepo(Message message);
  // Future<Either<DomainError, List<Message>>> chatConversationsRepo(userId);
}
