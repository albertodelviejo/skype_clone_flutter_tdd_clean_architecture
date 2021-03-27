import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';

class InitialWidget extends StatelessWidget {
  const InitialWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dispatchGetContacts(context);
    return Center(child: CircularProgressIndicator());
  }
}

void dispatchGetContacts(BuildContext context) {
  BlocProvider.of<ContactsBloc>(context).add(GetContactsEvent());
}
