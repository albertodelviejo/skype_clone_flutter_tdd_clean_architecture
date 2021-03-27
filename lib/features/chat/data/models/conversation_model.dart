import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConversationModel {
  final Timestamp date;
  final List messages;
  final String uid;

  ConversationModel(
      {@required this.date, @required this.messages, @required this.uid});

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
        date: json['date'], messages: json['messages'], uid: json['uid']);
  }

  Map<String, dynamic> toJson() {
    return {'date': date, 'messages': messages, 'uid': uid};
  }
}
