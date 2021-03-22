import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/domain/entities/user_app.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/domain/usecases/login.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/domain/usecases/logout.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/presentation/bloc/auth_event.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/presentation/bloc/auth_state.dart';

class MockLogin extends Mock implements Login {}

class MockLogout extends Mock implements Logout {}

void main() {
  MockLogin mockLogin;
  MockLogout mockLogout;
  AuthBloc bloc;

  setUp(() {
    mockLogin = MockLogin();
    mockLogout = MockLogout();
    bloc = AuthBloc(login: mockLogin, logout: mockLogout);
  });

  UserApp user = UserApp(
      uid: "1231",
      name: "test",
      email: "test",
      photoURL: "12314",
      searchKey: "t");

  test('initialState should be Empty', () {
    expect(bloc.initialState, equals(Empty()));
  });

  group('Login', () {
    test('should get data from Login usecase', () async {
      when(mockLogin(any)).thenAnswer((_) async => Right(user));

      bloc.add(LoginEvent());
      await untilCalled(mockLogin(any));

      verify(mockLogin(NoParams()));
    });

    blocTest(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockLogin(any)).thenAnswer((_) async => Right(user));
        return AuthBloc(login: mockLogin, logout: mockLogout);
      },
      act: (bloc) => bloc.add(LoginEvent()),
      expect: () => [Loading(), Loaded(user: user)],
    );

    blocTest(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        when(mockLogin(any)).thenAnswer((_) async => Left(ConnectionFailure()));
        return AuthBloc(login: mockLogin, logout: mockLogout);
      },
      act: (bloc) => bloc.add(LoginEvent()),
      expect: () => [Loading(), Error(message: CONNECTION_FAILURE_MESSAGE)],
    );
  });

  group('Logout', () {
    test('should get data from Logout usecase', () async {
      when(mockLogout(any)).thenAnswer((_) async => Right(true));

      bloc.add(LogoutEvent());
      await untilCalled(mockLogout(any));

      verify(mockLogout(NoParams()));
    });

    blocTest(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockLogout(any)).thenAnswer((_) async => Right(true));
        return AuthBloc(login: mockLogin, logout: mockLogout);
      },
      act: (bloc) => bloc.add(LogoutEvent()),
      expect: () => [Loading(), Empty()],
    );

    blocTest(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        when(mockLogout(any))
            .thenAnswer((_) async => Left(ConnectionFailure()));
        return AuthBloc(login: mockLogin, logout: mockLogout);
      },
      act: (bloc) => bloc.add(LogoutEvent()),
      expect: () => [Loading(), Error(message: CONNECTION_FAILURE_MESSAGE)],
    );
  });
}
