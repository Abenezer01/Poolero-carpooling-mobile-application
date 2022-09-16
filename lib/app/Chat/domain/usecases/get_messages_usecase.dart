import 'package:carpooling_beta/app/Chat/domain/entities/Message.dart';
import 'package:carpooling_beta/app/Chat/domain/repository/base_chat_repository.dart';
import 'package:carpooling_beta/app/Profile/domain/entities/Profile.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class GetMessagesUseCase {
  final BaseChatRepository baseChatRepository;

  GetMessagesUseCase(this.baseChatRepository);

  Future<Either<DomainError, Stream<List<Message>>>> call(
      String fromUserId, String toUserId) async {
    try {
      final messages =
          await baseChatRepository.getMessagesRepo(fromUserId, toUserId);

      return messages;
    } on DomainError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
