import 'package:flutter/foundation.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../auth/data/models/user_model.dart';
import '../datasources/search_data_source.dart';
import '../../domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource searchDataSource;

  SearchRepositoryImpl(this.searchDataSource);
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
