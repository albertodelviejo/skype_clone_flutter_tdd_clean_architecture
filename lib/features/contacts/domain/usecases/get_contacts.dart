import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/contacts_repostiory.dart';

class GetContacts implements UseCase<Iterable, NoParams> {
  final ContactsRepository contactsRepository;

  GetContacts(this.contactsRepository);

  @override
  Future<Either<Failure, Iterable>> call(NoParams params) {
    return contactsRepository.getContacts();
  }
}
