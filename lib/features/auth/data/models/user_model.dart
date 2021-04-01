import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/entities/user_app.dart';

class UserModel extends UserApp {
  UserModel(
      {@required String email,
      String username,
      String searchKey,
      String uid,
      String photoURL})
      : super(
            email: email,
            name: username,
            searchKey: username[0],
            uid: uid,
            photoURL: photoURL);

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
        email: user.email,
        username: user.displayName,
        photoURL: user.photoURL,
        searchKey: user.displayName[0],
        uid: user.uid);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      username: json['username'],
      photoURL: json['photoURL'],
      searchKey: json['searchKey'],
      uid: json['uid'],
    );
  }
}
