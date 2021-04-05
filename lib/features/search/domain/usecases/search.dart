import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../repositories/search_repository.dart';

class Search {
  final SearchRepository repository;

  Search(this.repository);

  Future<Either<Failure, dynamic>> call(SearchParams params) {
    return repository.getUserByName(params.searchField);
  }
}

class SearchParams extends Equatable {
  final String searchField;

  SearchParams({@required this.searchField});

  @override
  List<Object> get props => [searchField];
}
