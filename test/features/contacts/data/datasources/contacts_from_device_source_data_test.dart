import 'package:contacts_service/contacts_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/exceptions.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/data/datasources/contacts_from_device_source_data.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/domain/repository/contacts_repostiory.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  ContactsFromDeviceSourceData datasource;
  MockContactsRepository mockContactsRepository;
  var contacts = [Contact(displayName: "test")];

  setUp(() {
    datasource = ContactsFromDeviceSourceDataImpl();
    mockContactsRepository = MockContactsRepository();
  });

  test('should get a List Contacts from device', () async {
    when(mockContactsRepository.getContacts())
        .thenAnswer((_) async => Right(contacts));

    final result = await datasource.getContactsFromDevice();

    expect(result, Right(contacts));
  });

  test('should return an [Error] if the permission are not given', () async {
    expect(() => datasource.getContactsFromDevice(),
        throwsA(PermissionException()));
  });
}
