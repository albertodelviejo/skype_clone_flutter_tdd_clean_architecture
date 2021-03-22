import 'package:contacts_service/contacts_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/data/datasources/contacts_from_device_source_data.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/data/repository/contacts_repository_impl.dart';

class MockContactsFromDeviceSourceData extends Mock
    implements ContactsFromDeviceSourceData {}

void main() {
  MockContactsFromDeviceSourceData mockContactsFromDeviceSourceData;
  ContactsRepositoryImpl contactsRepositoryImpl;
  final contacts = [Contact(displayName: 'Test')];

  setUp(() {
    mockContactsFromDeviceSourceData = MockContactsFromDeviceSourceData();
    contactsRepositoryImpl =
        ContactsRepositoryImpl(mockContactsFromDeviceSourceData);
  });

  test('Should return Contacts list if the permission are given properly',
      () async {
    when(mockContactsFromDeviceSourceData.getContactsFromDevice())
        .thenAnswer((_) async => contacts);

    final result = await contactsRepositoryImpl.getContacts();

    expect(result, Right(contacts));
  });

  test('Should return Error if the permission are not given properly',
      () async {
    when(mockContactsFromDeviceSourceData.getContactsFromDevice())
        .thenAnswer((_) async => contacts);

    final result = await contactsRepositoryImpl.getContacts();

    expect(result, Left(PermissionFailure));
  });
}
