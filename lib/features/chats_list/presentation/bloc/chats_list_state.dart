part of 'chats_list_bloc.dart';

abstract class ChatsListState extends Equatable {
  const ChatsListState();
  @override
  List<Object> get props => [];
}

class ChatsListInitial extends ChatsListState {}

class ChatsListLoading extends ChatsListState {}

class ChatsListLoaded extends ChatsListState {
  final List<Chat> chatList;

  ChatsListLoaded({@required this.chatList});
}

class ChatListError extends ChatsListState {}

class ChatListPressed extends ChatsListState {
  final UserModel user;
  final UserModel peer;

  ChatListPressed({this.user, this.peer});
}
