import 'package:flutter/material.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/login/domain/repositories/login_firebase_repository.dart';

class Login {
  final LoginFirebaseRepository repository;

  Login({@required this.repository});
}
