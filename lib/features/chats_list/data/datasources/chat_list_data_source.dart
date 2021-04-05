import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/exceptions.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/data/models/user_model.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/domain/entities/chat.dart';

abstract class ChatListDataSource {
  Future<List<Chat>> getChatsFromUser(UserModel userModel);
}

class ChatListDataSourceImpl implements ChatListDataSource {
  final FirebaseFirestore firestore;

  ChatListDataSourceImpl({this.firestore});

  @override
  Future<List<Chat>> getChatsFromUser(UserModel userModel) async {
    List<Chat> chatList = [];
    try {
      await firestore
          .collection('conversations')
          .where('user1', isEqualTo: userModel.uid)
          .get()
          .then((value) => value.docs.forEach((element) {
                element.reference
                    .collection('messages')
                    .orderBy('date', descending: true)
                    .get()
                    .then((value) async {
                  await firestore
                      .collection('users')
                      .where('uid', isEqualTo: element.data()['user2'])
                      .get()
                      .then((user) {
                    chatList.add(
                      Chat.fromModels(
                          user1: userModel,
                          user2: UserModel.fromJson(user.docs.first.data()),
                          lastMessage: value.docs.first.data()['text']),
                    );
                  });
                });
              }));

      await firestore
          .collection('conversations')
          .where('user2', isEqualTo: userModel.uid)
          .get()
          .then((value) => value.docs.forEach((element) {
                element.reference
                    .collection('messages')
                    .orderBy('date', descending: true)
                    .get()
                    .then((value) async {
                  await firestore
                      .collection('users')
                      .where('uid', isEqualTo: element.data()['user1'])
                      .get()
                      .then((user) {
                    chatList.add(
                      Chat.fromModels(
                          user1: UserModel.fromJson(user.docs.first.data()),
                          user2: userModel,
                          lastMessage: value.docs.first.data()['text']),
                    );
                  });
                });
              }));
      return chatList;
    } on Exception {
      throw GetChatsException();
    }
  }
}
