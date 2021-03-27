import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/entities/user_app.dart';

class UserModel extends UserApp {
  UserModel(
      {@required String email,
      String name,
      String searchKey,
      String uid,
      String photoURL})
      : super(
            email: email,
            name: name,
            searchKey: name[0],
            uid: uid,
            photoURL: photoURL);

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
        email: user.email,
        name: user.displayName,
        photoURL: user.photoURL,
        searchKey: user.displayName[0],
        uid: user.uid);
  }
}
