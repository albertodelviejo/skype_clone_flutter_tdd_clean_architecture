part of 'auth_bloc_bloc.dart';

abstract class AuthBlocState extends Equatable {
  const AuthBlocState();

  @override
  List<Object> get props => [];
}

class Empty extends AuthBlocState {}

class Loading extends AuthBlocState {}

class Loaded extends AuthBlocState {
  final UserApp user;

  Loaded({@required this.user});
}

class Error extends AuthBlocState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
