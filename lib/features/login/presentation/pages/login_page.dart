import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/login/presentation/widgets/logout_button_widget.dart';
import '../bloc/bloc.dart';
import '../widgets/login_button_widget.dart';

import '../../../../injection_container.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }

  BlocProvider<AuthBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Empty) {
                return LoginButton();
              } else if (state is Loading) {
                return LoadingWidget();
              } else if (state is Loaded) {
                return LogoutButton();
              } else if (state is Error) {
                return ErrorDisplay();
              }
            },
          )
        ],
      ),
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
