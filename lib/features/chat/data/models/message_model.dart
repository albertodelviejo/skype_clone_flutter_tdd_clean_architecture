import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel(
      {@required String text,
      @required String senderUID,
      @required String receiverUID,
      @required Timestamp date,
      @required String photoURL,
      @required String type})
      : super(
            text: text,
            photoURL: photoURL,
            receiverUID: receiverUID,
            senderUID: senderUID,
            date: date,
            type: type);

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        text: json['text'],
        senderUID: json['senderUID'],
        receiverUID: json['receiverUID'],
        date: json['date'],
        type: json['type'],
        photoURL: json['photoURL']);
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'senderUID': senderUID,
      'receiverUID': receiverUID,
      'date': date,
      'type': type,
      'photoURL': photoURL
    };
  }
}
