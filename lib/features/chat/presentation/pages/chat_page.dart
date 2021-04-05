import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../contacts/presentation/bloc/bloc.dart';
import '../../data/models/message_model.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/chat_controls.dart';
import '../widgets/chat_message_item.dart';

import '../../../../injection_container.dart';

class ChatPage extends StatelessWidget {
  final List<UserModel> data;
  UserModel user;
  UserModel peer;

  ChatPage({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.length == 2) {
      user = data[0];
      peer = data[1];
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              BlocProvider.of<ContactsBloc>(context).add(GetContactsEvent());
              Navigator.of(context).pop();
            }),
        title: Text(peer.name),
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
          ChatControls(
            user1: user.uid,
            user2: peer.uid,
          )
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
                return InitialChatWidget(
                  user1: user.uid,
                  user2: peer.uid,
                );
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

class InitialChatWidget extends StatelessWidget {
  final String user1;
  final String user2;
  const InitialChatWidget({Key key, this.user1, this.user2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dispatchGetContacts(context, user1, user2);
    return Center(child: CircularProgressIndicator());
  }
}

void dispatchGetContacts(BuildContext context, String user1, String user2) {
  BlocProvider.of<ChatBloc>(context)
      .add(GetConversationEvent(user1: user1, user2: user2));
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
