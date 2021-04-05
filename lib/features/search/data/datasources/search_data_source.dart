import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/error/exceptions.dart';

abstract class SearchDataSource {
  Future<QuerySnapshot> getAllUsers();
}

class SearchDataSourceImpl implements SearchDataSource {
  final FirebaseFirestore firestore;

  SearchDataSourceImpl({@required this.firestore});

  @override
  Future<QuerySnapshot> getAllUsers() {
    try {
      return firestore.collection('users').get();
    } on Exception {
      throw SearchException();
    }
  }
}
