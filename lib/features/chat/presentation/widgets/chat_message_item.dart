import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/universal_variables.dart';
import '../../domain/entities/message.dart';

class ChatMessageItem extends StatelessWidget {
  final Message message;
  final User user;

  const ChatMessageItem({Key key, @required this.message, @required this.user})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        alignment: message.senderUID == user.uid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: message.senderUID == user.uid
            ? senderLayout(message, context)
            : receiverLayout(message, context),
      ),
    );
  }
}

Widget receiverLayout(Message message, BuildContext context) {
  Radius messageRadius = Radius.circular(10);

  return Container(
    margin: EdgeInsets.only(top: 12),
    constraints:
        BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
    decoration: BoxDecoration(
      color: UniversalVariables.receiverColor,
      borderRadius: BorderRadius.only(
        bottomRight: messageRadius,
        topRight: messageRadius,
        bottomLeft: messageRadius,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.all(10),
      child: getMessage(message),
    ),
  );
}

Widget senderLayout(Message message, BuildContext context) {
  Radius messageRadius = Radius.circular(10);

  return Container(
    margin: EdgeInsets.only(top: 12),
    constraints:
        BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
    decoration: BoxDecoration(
      color: UniversalVariables.senderColor,
      borderRadius: BorderRadius.only(
        topLeft: messageRadius,
        topRight: messageRadius,
        bottomLeft: messageRadius,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.all(10),
      child: getMessage(message),
    ),
  );
}

Widget getMessage(Message message) {
  return //message.type != MESSAGE_TYPE_IMAGE ?
      Text(
    message.text,
    style: TextStyle(
      color: Colors.white,
      fontSize: 16.0,
    ),
  );
  /*
        : message.photoURL != null
            ? CachedImage(
                message.photoURL,
                height: 250,
                width: 250,
                radius: 10,
              )
            : Text("Url was null");
            */
}
