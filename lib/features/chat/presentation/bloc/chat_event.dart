part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  List<Object> get props => [];
}

class GetConversationEvent extends ChatEvent {
  final String user1;
  final String user2;

  GetConversationEvent({
    @required this.user1,
    @required this.user2,
  });
}

class SendMessageEvent extends ChatEvent {
  final String conversationID;
  final String user1;
  final String user2;
  final Message message;

  SendMessageEvent(
      {@required this.conversationID,
      @required this.user1,
      @required this.user2,
      @required this.message});
}
