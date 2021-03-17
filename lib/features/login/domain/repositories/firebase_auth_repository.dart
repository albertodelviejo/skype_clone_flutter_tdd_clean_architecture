import 'package:dartz/dartz.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/exceptions.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/login/data/datasources/firebase_auth_remote_data_source.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/login/domain/entities/user_app.dart';

abstract class FirebaseAuthRepository {
  Future<Either<Failure, UserApp>> loginUser();
  Future<Either<Failure, bool>> logoutUser();
}

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
