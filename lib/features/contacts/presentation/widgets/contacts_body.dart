import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../bloc/bloc.dart';
import 'contact_tile.dart';

import '../../../../injection_container.dart';
import 'initial_widget.dart';
import 'loaded_widget.dart';
import 'loading_widget.dart';

BlocProvider<ContactsBloc> contactsBody(BuildContext context) {
  return BlocProvider(
    create: (_) => sl<ContactsBloc>(),
    child: BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        if (state is ContactsInitial) {
          return InitialWidget();
        }
        if (state is LoadingContacts) {
          return LoadingWidget();
        } else if (state is LoadedContacts) {
          Iterable contacts = state.contacts;
          return LoadedWidget(
            contacts: contacts,
          );
        } else if (state is ErrorContacts) {
          return Text("Error");
        }
      },
    ),
  );
}
