import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

class ConnectionFailure extends Failure {}
