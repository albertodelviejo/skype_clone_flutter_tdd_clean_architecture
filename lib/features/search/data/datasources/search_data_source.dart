import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/exceptions.dart';

class SearchDataSource {
  Future<QuerySnapshot> searchByName(String searchField) {
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .where('searchKey',
              isEqualTo: searchField.substring(0, 1).toUpperCase())
          .get();
    } on Exception {
      throw SearchException();
    }
  }
}
