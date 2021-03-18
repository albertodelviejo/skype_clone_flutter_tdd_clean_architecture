import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/firebase_auth_repository.dart';

class Logout implements UseCase<bool, NoParams> {
  final FirebaseAuthRepository repository;

  Logout(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.logoutUser();
  }
}
