import 'package:dartz/dartz.dart';
import '../entities/message.dart';
import '../../../../core/error/failures.dart';

abstract class ChatRepository {
  Either<Failure, Stream> getConversation(String conversationID);

  Future<Either<Failure, bool>> sendMessage(
      String conversationID, Message message);
}
