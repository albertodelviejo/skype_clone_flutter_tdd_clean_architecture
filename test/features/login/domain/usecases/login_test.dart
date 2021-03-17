import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/login/domain/entities/user_model.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/login/domain/repositories/login_firebase_repository.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/login/domain/usecases/login.dart';

class MockLoginFirebaseRepository extends Mock
    implements LoginFirebaseRepository {}

void main() {
  MockLoginFirebaseRepository mockLoginFirebaseRepository;
  Login usecase;

  setUp(() {
    mockLoginFirebaseRepository = MockLoginFirebaseRepository();
    usecase = Login(repository: mockLoginFirebaseRepository);
  });

  User user = User(
      uid: '2', name: 'test', email: 'mail', photoURL: 'test', searchKey: 't');

  group('login test cases', () {
    test('Should get user from repository', () async {
      when(mockLoginFirebaseRepository.loginUser(user))
          .thenAnswer((_) async => Right(user));

      final result = await mockLoginFirebaseRepository.loginUser(user);

      expect(result, equals(Right(user)));
    });

    test('Should get ConnectionFailure if no connection', () async {
      when(mockLoginFirebaseRepository.loginUser(user))
          .thenAnswer((_) async => Left(ConnectionFailure()));

      final result = await mockLoginFirebaseRepository.loginUser(user);

      expect(result, equals(Left(ConnectionFailure())));
    });
  });

  group('logout test cases', () {
    test('Should return true if the logout was succesful', () async {
      when(mockLoginFirebaseRepository.logoutUser(user))
          .thenAnswer((_) async => Right(true));

      final result = await mockLoginFirebaseRepository.logoutUser(user);

      expect(result, equals(Right(true)));
    });

    test('Should get ConnectionFailure if no connection', () async {
      when(mockLoginFirebaseRepository.logoutUser(user))
          .thenAnswer((_) async => Left(ConnectionFailure()));

      final result = await mockLoginFirebaseRepository.logoutUser(user);

      expect(result, equals(Left(ConnectionFailure())));
    });
  });
}
