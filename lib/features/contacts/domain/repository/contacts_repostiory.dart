import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class ContactsRepository {
  Future<Either<Failure, Iterable>> getContacts();
}
