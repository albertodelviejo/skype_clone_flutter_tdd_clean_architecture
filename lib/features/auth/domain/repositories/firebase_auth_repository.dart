import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_app.dart';

abstract class FirebaseAuthRepository {
  Future<Either<Failure, UserApp>> loginUser();
  Future<Either<Failure, bool>> logoutUser();
}
