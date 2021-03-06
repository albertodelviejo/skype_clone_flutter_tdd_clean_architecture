import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/bloc.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({
    Key key,
  }) : super(key: key);

  @override
  _LogoutButtonState createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Center(
          child: ElevatedButton(
        onPressed: dispatchLogout,
        child: Text('Logout from firebase'),
      )),
    );
  }

  void dispatchLogout() {
    BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
  }
}
