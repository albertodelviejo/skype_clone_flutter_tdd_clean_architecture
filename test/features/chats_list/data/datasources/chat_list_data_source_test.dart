import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/data/models/user_model.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/data/datasources/chat_list_data_source.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/injection_container.dart';

void main() {
  ChatListDataSource dataSource;
  UserModel userModel;

  setUp(() {
    dataSource = ChatListDataSourceImpl(firestore: sl<FirebaseFirestore>());
    // userModel = UserModel(email: email);
  });

  test("should fill a list which contains the user in the field user1 or user2",
      () {
    dataSource.getChatsFromUser(userModel);
  });
}
