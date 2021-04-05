import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'chats_list_event.dart';
part 'chats_list_state.dart';
class ChatsListBloc extends Bloc<ChatsListEvent, ChatsListState> {
  ChatsListBloc() : super(ChatsListInitial());
  @override
  Stream<ChatsListState> mapEventToState(
    ChatsListEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
