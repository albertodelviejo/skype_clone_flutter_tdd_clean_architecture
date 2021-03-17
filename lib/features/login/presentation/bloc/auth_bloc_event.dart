part of 'auth_bloc_bloc.dart';

abstract class AuthBlocEvent extends Equatable {
  const AuthBlocEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthBlocEvent {
  LoginEvent();
}

class LogoutEvent extends AuthBlocEvent {
  LogoutEvent();
}
