import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/domain/entities/user_app.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/domain/repositories/firebase_auth_repository.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/domain/usecases/login.dart';

class MockLoginFirebaseRepository extends Mock
    implements FirebaseAuthRepository {}

void main() {
  MockLoginFirebaseRepository mockLoginFirebaseRepository;
  Login usecase;

  setUp(() {
    mockLoginFirebaseRepository = MockLoginFirebaseRepository();
    usecase = Login(mockLoginFirebaseRepository);
  });

  UserApp user = UserApp(
      uid: '2', name: 'test', email: 'mail', photoURL: 'test', searchKey: 't');

  group('login test cases', () {
    test('Should get user from repository', () async {
      when(mockLoginFirebaseRepository.loginUser())
          .thenAnswer((_) async => Right(user));

      final result = await mockLoginFirebaseRepository.loginUser();

      expect(result, equals(Right(user)));
    });

    test('Should get ConnectionFailure if no connection', () async {
      when(mockLoginFirebaseRepository.loginUser())
          .thenAnswer((_) async => Left(ConnectionFailure()));

      final result = await mockLoginFirebaseRepository.loginUser();

      expect(result, equals(Left(ConnectionFailure())));
    });
  });

  group('logout test cases', () {
    test('Should return true if the logout was succesful', () async {
      when(mockLoginFirebaseRepository.logoutUser())
          .thenAnswer((_) async => Right(true));

      final result = await mockLoginFirebaseRepository.logoutUser();

      expect(result, equals(Right(true)));
    });

    test('Should get ConnectionFailure if no connection', () async {
      when(mockLoginFirebaseRepository.logoutUser())
          .thenAnswer((_) async => Left(ConnectionFailure()));

      final result = await mockLoginFirebaseRepository.logoutUser();

      expect(result, equals(Left(ConnectionFailure())));
    });
  });
}
