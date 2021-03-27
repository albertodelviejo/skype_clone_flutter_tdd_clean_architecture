import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/exceptions.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chat/data/datasources/chat_data_source.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chat/data/models/message_model.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chat/domain/entities/message.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chat/domain/repositories/chat_repository.dart';

class MockChatDataSource extends Mock implements ChatDataSource {}

void main() {
  MockChatDataSource mockChatDataSource;
  String conversationID;
  ChatRepository repository;
  MessageModel message;

  setUp(() {
    mockChatDataSource = MockChatDataSource();
    repository = ChatRepositoryImpl(mockChatDataSource);
    conversationID = "1234";
    message = MessageModel(
        text: "test",
        senderUID: "12345",
        receiverUID: "1234",
        type: "text",
        photoURL: "asdsafa",
        date: Timestamp.now());
  });

  test('Should return true if the message is sended correctly', () async {
    when(mockChatDataSource.sendMessage(conversationID, message))
        .thenAnswer((_) async => true);

    final result = await repository.sendMessage(conversationID, message);

    expectLater(result, Right(true));
  });

  test(
      'Should return [SendMessageFailure] when a message has not been properly sent',
      () async {
    when(mockChatDataSource.sendMessage(conversationID, message))
        .thenThrow(SendMessageException());

    final result = await repository.sendMessage(conversationID, message);

    expect(result, equals(Left(SendMessageFailure())));
  });
}
