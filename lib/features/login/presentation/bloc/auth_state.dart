import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/user_app.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends AuthState {}

class Loading extends AuthState {}

class Loaded extends AuthState {
  final UserApp user;
  final bool result;

  Loaded({this.user, this.result});

  @override
  List<Object> get props => [user, result];
}

class Error extends AuthState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
