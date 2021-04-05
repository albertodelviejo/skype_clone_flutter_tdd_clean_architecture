import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/domain/usecases/get_contacts.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/presentation/bloc/bloc.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/presentation/bloc/contacts_bloc.dart';

class MockGetContacts extends Mock implements GetContacts {}

void main() {
  MockGetContacts mockGetContacts;
  ContactsBloc bloc;
  var contacts;

  setUp(() {
    mockGetContacts = MockGetContacts();
    bloc = ContactsBloc(getContacts: mockGetContacts);
    contacts = [Contact()];
  });

  test('initial state should be ContactsInitial', () {
    expect(bloc.initialState, ContactsInitial());
  });

/*
  blocTest('should emit [Loading, Loaded] when data is loaded',
      build: () {
        when(mockGetContacts(any)).thenAnswer((_) async => Right(contacts));

        return ContactsBloc(getContacts: mockGetContacts);
      },
      act: (bloc) => bloc.add(GetContactsEvent()),
      expect: () => [LoadingContacts(), LoadedContacts(contacts: contacts)]);

  blocTest('should emit [Loading, Error] when data is not loaded properly',
      build: () {
        when(mockGetContacts(any))
            .thenAnswer((_) async => Left(PermissionFailure()));

        return ContactsBloc(getContacts: mockGetContacts);
      },
      act: (bloc) => bloc.add(GetContactsEvent()),
      expect: () =>
          [LoadingContacts(), ErrorContacts(message: "Error de permisos")]);
          */
}
