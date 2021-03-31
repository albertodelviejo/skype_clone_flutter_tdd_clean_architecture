import 'package:flutter/foundation.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/exceptions.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/search/data/datasources/search_data_source.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource searchDataSource;

  SearchRepositoryImpl(@required this.searchDataSource);
  @override
  Future<Either<Failure, QuerySnapshot>> getUserByName(
      String searchField) async {
    try {
      final result = await searchDataSource.searchByName(searchField);
      return Right(result);
    } on SearchException {
      return Left(SearchFailure());
    }
  }
}
