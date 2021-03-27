part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class LoadingConversation extends ChatState {}

class LoadedConversation extends ChatState {
  final Stream stream;

  LoadedConversation({@required this.stream});
}

class ErrorConversation extends ChatState {}

class SendingMessage extends ChatState {}

class SendedeMessage extends ChatState {}

class ErrorSendingMessage extends ChatState {}
