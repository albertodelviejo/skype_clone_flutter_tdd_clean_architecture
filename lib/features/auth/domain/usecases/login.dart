import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_app.dart';
import '../repositories/firebase_auth_repository.dart';

class Login implements UseCase<UserApp, NoParams> {
  final FirebaseAuthRepository repository;

  Login(this.repository);

  @override
  Future<Either<Failure, UserApp>> call(NoParams params) async {
    return await repository.loginUser();
  }
}
