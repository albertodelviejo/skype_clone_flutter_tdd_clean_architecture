import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/conversation_model.dart';
import '../../../../core/error/exceptions.dart';
import '../models/message_model.dart';

abstract class ChatDataSource {
  Stream getMessagesStream(String conversationID);

  Future<bool> sendMessage(String conversation, MessageModel message);
}

class ChatDataSourceImpl implements ChatDataSource {
  final FirebaseFirestore firebase;

  ChatDataSourceImpl({@required this.firebase});

  @override
  Stream getMessagesStream(String conversationID) {
    return firebase
        .collection('conversations')
        .doc(conversationID)
        .collection('messages')
        .orderBy('date', descending: true)
        .snapshots();
  }

  @override
  Future<bool> sendMessage(String conversationID, MessageModel message) async {
    try {
      DocumentReference docRef =
          firebase.collection('conversations').doc(conversationID);

      try {
        return await updateConversation(docRef: docRef, message: message);
      } on FirebaseException {
        return await createNewConversation(
            conversationID: conversationID, messageModel: message);
      }
    } on Exception {
      throw SendMessageException();
    }
  }

  Future<bool> updateConversation(
      {DocumentReference docRef, MessageModel message}) async {
    await docRef.collection('messages').add(message.toJson());

    return true;
  }

  Future<bool> createNewConversation(
      {String conversationID, MessageModel messageModel}) async {
    ConversationModel conversation = ConversationModel(
        date: Timestamp.now(),
        messages: [messageModel.toJson()],
        uid: conversationID);
    await firebase
        .collection('conversations')
        .doc(conversationID)
        .collection('messages')
        .add(conversation.toJson());

    return true;
  }
}
