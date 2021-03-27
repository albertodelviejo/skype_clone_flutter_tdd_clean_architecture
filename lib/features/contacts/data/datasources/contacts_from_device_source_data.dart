import 'package:contacts_service/contacts_service.dart';
import '../../../../core/error/exceptions.dart';

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
