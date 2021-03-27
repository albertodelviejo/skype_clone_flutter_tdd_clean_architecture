import '../../../../core/error/exceptions.dart';

import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../datasources/contacts_from_device_source_data.dart';
import '../../domain/repository/contacts_repostiory.dart';

class ContactsRepositoryImpl extends ContactsRepository {
  final ContactsFromDeviceSourceData contactsFromDeviceSourceData;

  ContactsRepositoryImpl(this.contactsFromDeviceSourceData);

  @override
  Future<Either<Failure, Iterable>> getContacts() async {
    try {
      final contacts =
          await contactsFromDeviceSourceData.getContactsFromDevice();
      return Right(contacts);
    } on PermissionException {
      return Left(PermissionFailure());
    }
  }
}
