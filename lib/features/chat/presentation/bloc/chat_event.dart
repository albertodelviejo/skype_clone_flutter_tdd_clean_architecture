part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  List<Object> get props => [];
}

class GetConversationEvent extends ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String conversationID;
  final Message message;

  SendMessageEvent({@required this.conversationID, @required this.message});
}
