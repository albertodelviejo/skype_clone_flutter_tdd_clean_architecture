import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chat/domain/entities/message.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chat/domain/repositories/chat_repository.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chat/domain/usecases/send_message.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  MockChatRepository mockChatRepository;
  SendMessage usecase;
  String conversationID;
  Message message;

  setUp(() {
    mockChatRepository = new MockChatRepository();
    usecase = new SendMessage(mockChatRepository);
    conversationID = '123';
    message = Message(
        date: Timestamp.now(),
        text: "test",
        senderUID: "1231241",
        receiverUID: "123124",
        type: "text",
        photoURL: "1231asfasf");
  });

  test('should return true when the message is correctly sended', () async {
    when(mockChatRepository.sendMessage(conversationID, "1", "2", message))
        .thenAnswer((_) async => Right(true));

    final result = await usecase(SendMessageParams(
        conversationID: conversationID,
        user1: "1",
        user2: "2",
        message: message));

    expect(result, Right(true));
  });

  test('should return [SendMessageFailure] when the message can not be sended',
      () async {
    when(mockChatRepository.sendMessage(conversationID, "1", "2", message))
        .thenAnswer((_) async => Left(SendMessageFailure()));

    final result = await usecase(SendMessageParams(
        conversationID: conversationID,
        user1: "1",
        user2: "2",
        message: message));

    expect(result, Left(SendMessageFailure()));
  });
}
