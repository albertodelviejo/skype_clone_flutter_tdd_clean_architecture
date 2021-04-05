import 'package:flutter/foundation.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/data/models/user_model.dart';

class Chat {
  final String lastMessage;
  final UserModel user1;
  final UserModel user2;

  Chat({
    @required this.lastMessage,
    @required this.user1,
    @required this.user2,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
        lastMessage: json['messages'],
        user1: json['user1'],
        user2: json['user2']);
  }

  factory Chat.fromModels(
      {UserModel user1, UserModel user2, String lastMessage}) {
    return Chat(lastMessage: lastMessage, user1: user1, user2: user2);
  }
}
