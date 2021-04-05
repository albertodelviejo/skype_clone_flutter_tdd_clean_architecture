part of 'chats_list_bloc.dart';

abstract class ChatsListEvent extends Equatable {
  const ChatsListEvent();

  @override
  List<Object> get props => throw UnimplementedError();
}

class GetChatsEvent extends ChatsListEvent {}

class ChatListTilePressed extends ChatsListEvent {
  final UserModel user;
  final UserModel peer;

  ChatListTilePressed({@required this.user, @required this.peer});
}
