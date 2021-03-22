import 'package:contacts_service/contacts_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/domain/repository/contacts_repostiory.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/domain/usecases/get_contacts.dart';

class MockContactRepository extends Mock implements ContactsRepository {}

void main() {
  MockContactRepository mockContactRepository;
  GetContacts usecase;
  var contacts;

  setUp(() {
    mockContactRepository = MockContactRepository();
    contacts = [Contact(displayName: "Test")];
    usecase = GetContacts(mockContactRepository);
  });

  test('should return a List of Contact if the query is correct', () async {
    when(mockContactRepository.getContacts())
        .thenAnswer((_) async => Right(contacts));

    final result = await usecase(NoParams());

    expect(result, equals(Right(contacts)));
  });

  test('should return failure when an error ocurred getting contacts',
      () async {
    when(mockContactRepository.getContacts())
        .thenAnswer((_) async => Left(PermissionFailure()));

    final result = await usecase(NoParams());

    expect(result, Left(PermissionFailure()));
  });
}
