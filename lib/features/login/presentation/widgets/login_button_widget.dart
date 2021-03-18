import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({
    Key key,
  }) : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Center(
          child: ElevatedButton(
        onPressed: dispatchLogin,
        child: Text('Sign in with Google'),
      )),
    );
  }

  void dispatchLogin() {
    BlocProvider.of<AuthBloc>(context).add(LoginEvent());
  }
}
