import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../datasources/firebase_auth_remote_data_source.dart';
import '../../domain/entities/user_app.dart';
import '../../domain/repositories/firebase_auth_repository.dart';

class FirebaseAuthRepositoryImpl extends FirebaseAuthRepository {
  final FirebaseAuthRemoteDataSource remoteDataSource;

  FirebaseAuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserApp>> loginUser() async {
    try {
      final user = await remoteDataSource.loginUserInFirebase();
      return Right(user);
    } on ConnectionException {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logoutUser() {
    // TODO: implement logoutUser
    throw UnimplementedError();
  }
}
