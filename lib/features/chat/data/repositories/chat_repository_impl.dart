import '../models/message_model.dart';

import '../../domain/entities/message.dart';

import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../datasources/chat_data_source.dart';
import '../../domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource chatDataSource;

  ChatRepositoryImpl(this.chatDataSource);

  @override
  Either<Failure, Stream> getConversation(String conversationID) {
    try {
      return Right(chatDataSource.getMessagesStream(conversationID));
    } on Exception {
      return Left(GetConversationFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> sendMessage(String conversationID, String user1,
      String user2, Message message) async {
    MessageModel messageModel = MessageModel(
        text: message.text,
        senderUID: message.senderUID,
        receiverUID: message.receiverUID,
        date: message.date,
        photoURL: message.photoURL,
        type: message.type);
    try {
      return Right(await chatDataSource.sendMessage(
          conversationID, user1, user2, messageModel));
    } on Exception {
      return Future.value(Left(SendMessageFailure()));
    }
  }
}
