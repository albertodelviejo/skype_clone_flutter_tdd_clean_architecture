import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message {
  final String text;
  final String senderUID;
  final String receiverUID;
  final String type;
  final String photoURL;
  final Timestamp date;

  Message(
      {@required this.text,
      @required this.senderUID,
      @required this.receiverUID,
      @required this.type,
      @required this.photoURL,
      @required this.date});
}
