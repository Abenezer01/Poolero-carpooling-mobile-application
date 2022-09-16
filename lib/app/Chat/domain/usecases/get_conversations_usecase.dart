import 'package:carpooling_beta/app/Chat/domain/repository/base_chat_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:carpooling_beta/app/core/local_database/models/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class GetConversationsUseCase {
  final BaseChatRepository baseChatRepository;

  GetConversationsUseCase(this.baseChatRepository);

  Future<Either<DomainError, List<User>>> call(String userId) async {
    try {
      final conversations =
          await baseChatRepository.chatConversationsRepo(userId);
      print('GetConversationsUseCase');
      print(conversations);
      return conversations;
    } on DomainError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
