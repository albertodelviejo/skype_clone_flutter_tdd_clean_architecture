import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_contacts.dart';
import 'bloc.dart';

const String CONTACTS_ERROR_MESSAGE = "Error de permisos";

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final GetContacts getContacts;

  ContactsBloc({this.getContacts})
      : assert(getContacts != null),
        super(ContactsInitial());

  @override
  Stream<ContactsState> mapEventToState(
    ContactsEvent event,
  ) async* {
    if (event is GetContactsEvent) {
      yield LoadingContacts();

      final permission = await _getPermission();

      if (permission.isGranted) {
        final getContactEither = await getContacts(NoParams());

        yield* getContactEither.fold(
          (failure) async* {
            yield ErrorContacts(message: CONTACTS_ERROR_MESSAGE);
          },
          (list) async* {
            yield LoadedContacts(contacts: list);
          },
        );
      } else {
        yield ErrorContacts(message: CONTACTS_ERROR_MESSAGE);
      }
    }
  }

  get initialState => ContactsInitial();
}

Future<PermissionStatus> _getPermission() async {
  final PermissionStatus permission = await Permission.contacts.status;
  if (permission != PermissionStatus.granted &&
      permission != PermissionStatus.permanentlyDenied) {
    final Map<Permission, PermissionStatus> permissionStatus =
        await [Permission.contacts].request();
    return permissionStatus[Permission.contacts] ??
        PermissionStatus.permanentlyDenied;
  } else {
    return permission;
  }
}
