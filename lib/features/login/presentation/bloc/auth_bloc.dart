import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../domain/usecases/logout.dart';
import 'bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/login.dart';

const String CONNECTION_FAILURE_MESSAGE = 'Error de red';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Logout logout;

  AuthBloc({@required this.login, @required this.logout})
      : assert(login != null),
        assert(logout != null),
        super(Empty());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoginEvent) {
      yield Loading();
      final loginEither = await login(NoParams());

      yield* loginEither.fold((failure) async* {
        yield Error(message: CONNECTION_FAILURE_MESSAGE);
      }, (user) async* {
        yield Loaded(user: user);
      });
    } else if (event is LogoutEvent) {
      yield Loading();
      final logoutEither = await logout(NoParams());

      yield* logoutEither.fold((failure) async* {
        yield Error(message: CONNECTION_FAILURE_MESSAGE);
      }, (bool) async* {
        yield Empty();
      });
    }
  }

  get initialState => Empty();
}
