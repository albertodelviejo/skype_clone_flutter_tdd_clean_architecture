import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/data/datasources/contacts_from_device_source_data.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/domain/repository/contacts_repostiory.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/domain/usecases/get_contacts.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/presentation/bloc/contacts_bloc.dart';

import 'features/auth/data/datasources/firebase_auth_remote_data_source.dart';
import 'features/auth/data/repositories/firebase_auth_repository_impl.dart';
import 'features/auth/domain/repositories/firebase_auth_repository.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/domain/usecases/logout.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/contacts/data/repository/contacts_repository_impl.dart';

final sl = GetIt.instance;

init() async {
// Bloc
  sl.registerFactory(() => AuthBloc(
        login: sl(),
        logout: sl(),
      ));

  sl.registerFactory(() => ContactsBloc(
        getContacts: sl(),
      ));

// Use cases

  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => GetContacts(sl()));

// Repository
  sl.registerLazySingleton<FirebaseAuthRepository>(
      () => FirebaseAuthRepositoryImpl(sl()));
  sl.registerLazySingleton<ContactsRepository>(
      () => ContactsRepositoryImpl(sl()));

// Data sources
  sl.registerLazySingleton<FirebaseAuthRemoteDataSource>(
      () => FirebaseAuthRemoteDataSourceImpl(auth: sl()));
  sl.registerLazySingleton<ContactsFromDeviceSourceData>(
      () => ContactsFromDeviceSourceDataImpl());

// Externals
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}
