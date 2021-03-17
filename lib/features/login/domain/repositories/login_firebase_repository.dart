import 'package:dartz/dartz.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/login/domain/entities/user_model.dart';

abstract class LoginFirebaseRepository {
  Future<Either<Failure, User>> loginUser(User user);
  Future<Either<Failure, bool>> logoutUser(User user);
}
