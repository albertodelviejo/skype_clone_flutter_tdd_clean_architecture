import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/logout_button_widget.dart';
import '../bloc/bloc.dart';
import '../widgets/login_button_widget.dart';

import '../../../../injection_container.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: Scaffold(
        body: SingleChildScrollView(child: buildBody(context)),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Loaded) {
              Navigator.pushNamed(context, '/home');
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Empty) {
                return LoginButton();
              } else if (state is Loading) {
                return LoadingWidget();
              } else if (state is Loaded) {
                return LoadingNextScreen();
              } else if (state is Error) {
                return ErrorDisplay();
              }
            },
          ),
        ),
        SizedBox(
          height: 100,
        ),
      ],
    );
  }
}

class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Error en Login');
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class LoadingNextScreen extends StatelessWidget {
  final User user;

  const LoadingNextScreen({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
