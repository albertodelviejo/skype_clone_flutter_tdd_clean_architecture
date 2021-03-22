import 'package:contacts_service/contacts_service.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/exceptions.dart';

abstract class ContactsFromDeviceSourceData {
  Future<Iterable> getContactsFromDevice();
}

class ContactsFromDeviceSourceDataImpl implements ContactsFromDeviceSourceData {
  @override
  Future<Iterable> getContactsFromDevice() async {
    try {
      final Iterable<Contact> contacts = await ContactsService.getContacts();
      return contacts;
    } on Exception {
      throw PermissionException();
    }
  }
}
