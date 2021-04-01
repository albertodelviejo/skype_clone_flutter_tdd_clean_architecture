import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/exceptions.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/data/models/user_model.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/search/data/datasources/search_data_source.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource searchDataSource;

  SearchRepositoryImpl(@required this.searchDataSource);
  @override
  Future<Either<Failure, List<UserModel>>> getUserByName(
      String searchField) async {
    List<UserModel> searchList = [];

    try {
      QuerySnapshot result = await searchDataSource.getAllUsers();
      result.docs.forEach((element) {
        if (element.data()['username'].startsWith(searchField)) {
          searchList.add(UserModel.fromJson(element.data()));
        }
      });

      return Right(searchList);
    } on SearchException {
      return Left(SearchFailure());
    }
  }
}
