import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseAuthRemoteDataSource {
  Future<UserModel> loginUserInFirebase();
  Future<bool> logoutUserInFirebase();

  Future<bool> addOrUpdateUserDb(User user);
}

class FirebaseAuthRemoteDataSourceImpl implements FirebaseAuthRemoteDataSource {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  FirebaseAuthRemoteDataSourceImpl({@required this.auth});

  @override
  Future<UserModel> loginUserInFirebase() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    try {
      final result = await auth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: gSA.idToken, accessToken: gSA.accessToken));

      await addOrUpdateUserDb(result.user);

      return UserModel.fromFirebaseUser(result.user);
    } on ConnectionFailure {
      throw ConnectionException();
    }
  }

  Future<bool> logoutUserInFirebase() async {
    try {
      await auth.signOut().then((onValue) => print("Sesión cerrada"));
      return await googleSignIn.signOut().then((value) => true);
    } on ConnectionFailure {
      throw ConnectionException();
    }
  }

  @override
  Future<bool> addOrUpdateUserDb(User user) async {
    var _chatsCollection = FirebaseFirestore.instance.collection('users');
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: user.uid)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length == 0) {
      var result = await _chatsCollection.add({
        "uid": user.uid,
        "username": user.displayName,
        "email": user.email,
        "searchKey": user.displayName[0]
      });
      return (result != null) ? true : false;
    }
    return true;
  }
}
