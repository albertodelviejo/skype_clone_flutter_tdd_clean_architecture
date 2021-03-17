import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../models/user_model.dart';

abstract class FirebaseAuthRemoteDataSource {
  Future<UserModel> loginUserInFirebase();
  Future<bool> logoutUserInFirebase();
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

      return UserModel(firebaseUser: result.user);
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
}
