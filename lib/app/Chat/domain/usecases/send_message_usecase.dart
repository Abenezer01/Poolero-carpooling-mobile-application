import 'package:carpooling_beta/app/Chat/domain/entities/Message.dart';
import 'package:carpooling_beta/app/Chat/domain/repository/base_chat_repository.dart';
import 'package:carpooling_beta/app/core/error_handling/domain_error.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class SendMessageUseCase {
  final BaseChatRepository baseChatRepository;

  SendMessageUseCase(this.baseChatRepository);

  Future<Either<DomainError, Message>> call(Message message) async {
    try {
      final newMessage = await baseChatRepository.sendMessageRepo(message);

      return newMessage;
    } on DomainError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
