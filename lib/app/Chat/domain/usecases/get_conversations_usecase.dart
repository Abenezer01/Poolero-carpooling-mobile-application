import 'package:carpooling_beta/app/Chat/domain/entities/Message.dart';
import 'package:carpooling_beta/app/Chat/domain/repository/base_chat_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class GetConversationsUseCase {
  final BaseChatRepository baseChatRepository;

  GetConversationsUseCase(this.baseChatRepository);

  Future<Either<DomainError, List<Message>>> call(String userId) async {
    try {
      final conversations =
          await baseChatRepository.chatConversationsRepo(userId);

      return conversations;
    } on DomainError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
