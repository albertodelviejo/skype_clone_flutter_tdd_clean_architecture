import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/presentation/bloc/chats_list_bloc.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/presentation/widgets/chat_tile.dart';

BlocListener<ChatsListBloc, ChatsListState> chatsBody(
    BuildContext buildContext) {
  return BlocListener<ChatsListBloc, ChatsListState>(
      listener: (context, state) {
    if (state is ChatListPressed) {
      Navigator.of(context).pushNamed('/chat', arguments: [
        state.user,
        state.peer,
      ]);
      dispatchGetChats(context);
    }
  }, child: BlocBuilder<ChatsListBloc, ChatsListState>(
    builder: (context, state) {
      if (state is ChatsListInitial) {
        return ChatListInitialWidget();
      } else if (state is ChatsListLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is ChatsListLoaded) {
        return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: state.chatList.length,
            itemBuilder: (BuildContext context, int index) {
              return ChatTile.fromChat(state.chatList[index]);
            });
      } else if (state is ChatListError) {
        return Text("Error");
      }
      return Center(child: CircularProgressIndicator());
    },
  ));
}

class ChatListInitialWidget extends StatelessWidget {
  const ChatListInitialWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dispatchGetChats(context);
    return Container();
  }
}

void dispatchGetChats(BuildContext context) {
  BlocProvider.of<ChatsListBloc>(context).add(GetChatsEvent());
}
