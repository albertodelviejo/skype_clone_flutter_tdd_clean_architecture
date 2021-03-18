import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'features/login/data/repositories/firebase_auth_repository_impl.dart';
import 'features/login/domain/repositories/firebase_auth_repository.dart';
import 'features/login/domain/usecases/login.dart';
import 'features/login/presentation/bloc/auth_bloc.dart';

import 'features/login/data/datasources/firebase_auth_remote_data_source.dart';
import 'features/login/domain/usecases/logout.dart';

final sl = GetIt.instance;

init() async {
// Bloc
  sl.registerFactory(() => AuthBloc(
        login: sl(),
        logout: sl(),
      ));

// Use cases

  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Logout(sl()));

// Repository
  sl.registerLazySingleton<FirebaseAuthRepository>(
      () => FirebaseAuthRepositoryImpl(sl()));

// Data sources
  sl.registerLazySingleton<FirebaseAuthRemoteDataSource>(
      () => FirebaseAuthRemoteDataSourceImpl(auth: sl()));

// Externals
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}
