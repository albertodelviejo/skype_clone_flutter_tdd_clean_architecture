import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chat/data/models/message_model.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/chat_controls.dart';
import '../widgets/chat_message_item.dart';

import '../../../../injection_container.dart';

class ChatPage extends StatelessWidget {
  final User user;
  final User peer;

  ChatPage({Key key, this.user, this.peer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text("Test"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.video_call),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.call),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Flexible(child: Container(child: buildBody(context))),
          ChatControls()
        ],
      ),
    );
  }

  BlocProvider<ChatBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChatBloc>(),
      child: Column(
        children: <Widget>[
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatInitial) {
                return InitialChatWIdget();
              } else if (state is LoadingConversation) {
                return Center(child: CircularProgressIndicator());
              } else if (state is LoadedConversation) {
                Stream messageStream = state.stream;
                return LoadedConversationWidget(
                  messageStream: messageStream,
                );
              } else if (state is ErrorConversation) {
                return Text("Inicie una nueva conversacion");
              }
            },
          ),
        ],
      ),
    );
  }
}

class InitialChatWIdget extends StatelessWidget {
  const InitialChatWIdget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dispatchGetContacts(context);
    return Center(child: CircularProgressIndicator());
  }
}

void dispatchGetContacts(BuildContext context) {
  BlocProvider.of<ChatBloc>(context).add(GetConversationEvent());
}

class LoadedConversationWidget extends StatelessWidget {
  const LoadedConversationWidget({
    Key key,
    @required this.messageStream,
  }) : super(key: key);

  final Stream<QuerySnapshot> messageStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }

        return Flexible(
          child: ListView.builder(
            padding: EdgeInsets.all(10),
            reverse: true,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              // mention the arrow syntax if you get the time
              return ChatMessageItem(
                message:
                    MessageModel.fromJson(snapshot.data.docs[index].data()),
                user: sl<FirebaseAuth>().currentUser,
              );
            },
          ),
        );
      },
    );
  }
}
