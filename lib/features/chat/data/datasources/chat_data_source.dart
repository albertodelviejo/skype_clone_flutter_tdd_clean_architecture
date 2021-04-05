import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/conversation_model.dart';
import '../../../../core/error/exceptions.dart';
import '../models/message_model.dart';

abstract class ChatDataSource {
  Stream getMessagesStream(String conversationID);

  Future<bool> sendMessage(
      String conversation, String user1, String user2, MessageModel message);
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
  Future<bool> sendMessage(String conversationID, String user1, String user2,
      MessageModel message) async {
    try {
      DocumentReference docRef =
          firebase.collection('conversations').doc(conversationID);

      try {
        return await updateConversation(
            docRef: docRef, user1: user1, user2: user2, message: message);
      } on FirebaseException {
        return await createNewConversation(
            conversationID: conversationID,
            user1: user1,
            user2: user2,
            messageModel: message);
      }
    } on Exception {
      throw SendMessageException();
    }
  }

  Future<bool> updateConversation(
      {DocumentReference docRef,
      String user1,
      String user2,
      MessageModel message}) async {
    await docRef.collection('messages').add(message.toJson());
    await docRef.update({
      'user1': user1,
      'user2': user2,
    });

    return true;
  }

  Future<bool> createNewConversation(
      {String conversationID,
      String user1,
      String user2,
      MessageModel messageModel}) async {
    ConversationModel conversation = ConversationModel(
        date: Timestamp.now(),
        messages: [messageModel.toJson()],
        uid: conversationID);

    DocumentReference docRef =
        firebase.collection('conversations').doc(conversationID);

    await docRef.set({
      'user1': user1,
      'user2': user2,
    });

    return true;
  }
}
