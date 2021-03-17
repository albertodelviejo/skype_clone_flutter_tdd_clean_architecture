import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class User extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final String searchKey;

  User(
      {@required this.uid,
      @required this.name,
      @required this.email,
      @required this.photoURL,
      @required this.searchKey})
      : super([uid, name, email, photoURL, searchKey]);
}
