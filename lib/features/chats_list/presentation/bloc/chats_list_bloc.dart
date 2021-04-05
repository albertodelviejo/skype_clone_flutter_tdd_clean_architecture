import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/data/models/user_model.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/domain/entities/chat.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/domain/usecases/get_chats_list.dart';

import '../../../../injection_container.dart';
part 'chats_list_event.dart';
part 'chats_list_state.dart';

class ChatsListBloc extends Bloc<ChatsListEvent, ChatsListState> {
  final GetChatsList getChatsList;
  ChatsListBloc({this.getChatsList}) : super(ChatsListInitial());
  @override
  Stream<ChatsListState> mapEventToState(
    ChatsListEvent event,
  ) async* {
    if (event is GetChatsEvent) {
      yield ChatsListLoading();

      final eitherFailureOrList = await getChatsList(ChatsListParams(
          user: UserModel.fromFirebaseUser(sl<FirebaseAuth>().currentUser)));

      yield* eitherFailureOrList.fold((l) async* {
        yield ChatListError();
      }, (r) async* {
        yield ChatsListLoaded(chatList: r);
      });
    } else if (event is ChatListTilePressed) {
      yield ChatListPressed(user: event.user, peer: event.peer);
    }
  }
}
