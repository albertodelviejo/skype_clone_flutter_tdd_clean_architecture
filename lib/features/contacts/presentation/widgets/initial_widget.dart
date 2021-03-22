import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/presentation/bloc/bloc.dart';

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
