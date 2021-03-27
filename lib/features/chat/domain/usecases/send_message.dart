import 'package:flutter/material.dart';
import '../entities/message.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/chat_repository.dart';

class SendMessage extends UseCase<bool, SendMessageParams> {
  final ChatRepository repository;

  SendMessage(this.repository);

  @override
  Future<Either<Failure, bool>> call(SendMessageParams params) {
    return repository.sendMessage(params.conversationID, params.message);
  }
}

class SendMessageParams {
  final String conversationID;
  final Message message;

  SendMessageParams({@required this.conversationID, @required this.message});
}
