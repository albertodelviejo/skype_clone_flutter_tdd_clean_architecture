import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../repositories/chat_repository.dart';

class GetConversation {
  final ChatRepository repository;

  GetConversation(this.repository);

  Either<Failure, Stream> call(Params params) {
    return repository.getConversation(params.conversationID);
  }
}

class Params extends Equatable {
  final String conversationID;

  const Params({@required this.conversationID});

  @override
  List<Object> get props => [conversationID];
}
