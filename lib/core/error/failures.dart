import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class ConnectionFailure extends Failure {}

class PermissionFailure extends Failure {}
