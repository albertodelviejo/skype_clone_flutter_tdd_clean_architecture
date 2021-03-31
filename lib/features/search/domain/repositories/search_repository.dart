import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/failures.dart';

abstract class SearchRepository {
  Future<Either<Failure, QuerySnapshot>> getUserByName(String searchField);
}
