import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chat/domain/repositories/chat_repository.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chat/domain/usecases/get_conversation.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  MockChatRepository mockChatRepository;
  Stream messages;
  String conversationID;
  GetConversation usecase;

  setUp(() {
    mockChatRepository = new MockChatRepository();
    conversationID = '123';
    usecase = GetConversation(mockChatRepository);
  });

  test('should return a list of DocumentSnapshot with the messages', () {
    when(mockChatRepository.getConversation(conversationID))
        .thenAnswer((_) => Right(messages));

    final result = usecase(Params(conversationID: conversationID));

    expect(result, equals(Right(messages)));
  });

  test(
      'should return [GetConversationFailure] if there is some problem getting the conversation',
      () {
    when(mockChatRepository.getConversation(conversationID))
        .thenAnswer((_) => Left(GetConversationFailure()));

    final result = usecase(Params(conversationID: conversationID));

    expect(result, equals(Left(GetConversationFailure())));
  });
}
