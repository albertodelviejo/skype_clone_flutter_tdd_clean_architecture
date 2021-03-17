import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user_app.dart';
import '../../domain/usecases/login.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final Login login;
  final Logout logout;

  AuthBlocBloc({@required this.login, @required this.logout})
      : assert(login != null),
        assert(logout != null),
        super(Empty());

  @override
  Stream<AuthBlocState> mapEventToState(
    AuthBlocEvent event,
  ) async* {
    if (event is LoginEvent) {
      yield Loading();
      final loginEither = await login(NoParams());

      yield* loginEither.fold((failure) async* {
        yield Error(message: 'Error de red');
      }, (user) async* {
        yield Loaded(user: user);
      });
    } else if (event is LogoutEvent) {
      yield Loading();
      final logoutEither = await logout(NoParams());
      yield* logoutEither.fold((failure) async* {
        yield Error(message: 'Error de red');
      }, (bool) async* {
        yield Loaded(user: bool);
      });
    }
  }
}
