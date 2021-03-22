import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/entities/user_app.dart';

class UserModel extends UserApp {
  UserModel({@required User firebaseUser})
      : super(
            email: firebaseUser.email,
            name: firebaseUser.displayName,
            searchKey: firebaseUser.displayName[0],
            uid: firebaseUser.uid,
            photoURL: firebaseUser.photoURL);

  factory UserModel.fromFirebaseUser(User firebaseUser) {
    return UserModel(firebaseUser: firebaseUser);
  }
}
