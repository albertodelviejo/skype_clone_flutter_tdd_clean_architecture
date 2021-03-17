import 'dart:html';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_app.dart';
import '../repositories/firebase_auth_repository.dart';

class Login implements UseCase<UserApp, NoParams> {
  final FirebaseAuthRepository repository;

  Login(this.repository);

  @override
  Future<Either<Failure, UserApp>> call(NoParams params) async {
    return await repository.loginUser();
  }
}

class Logout implements UseCase<bool, NoParams> {
  final FirebaseAuthRepository repository;

  Logout(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.logoutUser();
  }
}

class Params extends Equatable {
  final int number;

  const Params({@required this.number});

  @override
  List<Object> get props => [number];
}
