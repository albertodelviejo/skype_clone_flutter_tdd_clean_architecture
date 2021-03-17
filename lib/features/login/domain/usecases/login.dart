import 'package:flutter/material.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/login/domain/repositories/firebase_auth_repository.dart';

class Login {
  final FirebaseAuthRepository repository;

  Login({@required this.repository});
}
