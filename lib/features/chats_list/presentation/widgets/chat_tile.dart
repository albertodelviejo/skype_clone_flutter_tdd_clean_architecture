import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/data/models/user_model.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/domain/entities/chat.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/presentation/bloc/chats_list_bloc.dart';

import '../../../../injection_container.dart';

class ChatTile extends StatelessWidget {
  final String lastMessage;
  final UserModel userPeer;
  const ChatTile({@required this.lastMessage, @required this.userPeer, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          BlocProvider.of<ChatsListBloc>(context).add(ChatListTilePressed(
              user: UserModel.fromFirebaseUser(sl<FirebaseAuth>().currentUser),
              peer: userPeer));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.network(userPeer.photoURL),
              ),
              SizedBox(
                height: 20,
                width: 20,
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      userPeer.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      lastMessage,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Colors.white60),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  factory ChatTile.fromChat(Chat chat) {
    return ChatTile(
      userPeer: chat.user2,
      lastMessage: chat.lastMessage,
    );
  }
}
