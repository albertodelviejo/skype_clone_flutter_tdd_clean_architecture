import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';

import 'initial_widget.dart';
import 'loaded_widget.dart';
import 'loading_widget.dart';

BlocBuilder<ContactsBloc, ContactsState> contactsBody(
    BuildContext buildContext) {
  return BlocBuilder<ContactsBloc, ContactsState>(
    builder: (context, state) {
      if (state is ContactsInitial) {
        return InitialWidget();
      } else if (state is LoadingContacts) {
        return LoadingWidget();
      } else if (state is LoadedContacts) {
        Iterable contacts = state.contacts;
        return LoadedWidget(
          contacts: contacts,
        );
      } else if (state is ErrorContacts) {
        return Text("Error");
      }
      return LoadingWidget();
    },
  );
}
