import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/data/datasources/chat_list_data_source.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/data/repositories/chat_list_repository_impl.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/domain/repositories/chats_list_repository.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/domain/usecases/get_chats_list.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/presentation/bloc/chats_list_bloc.dart';
import 'features/search/data/datasources/search_data_source.dart';
import 'features/search/data/repositories/search_repository_impl.dart';
import 'features/search/domain/repositories/search_repository.dart';
import 'features/search/domain/usecases/search.dart';
import 'features/search/presentation/bloc/search_bloc.dart';
import 'features/chat/data/datasources/chat_data_source.dart';
import 'features/chat/domain/usecases/get_conversation.dart';
import 'features/chat/domain/usecases/send_message.dart';
import 'features/chat/presentation/bloc/chat_bloc.dart';
import 'features/chat/data/repositories/chat_repository_impl.dart';
import 'features/chat/domain/repositories/chat_repository.dart';
import 'features/contacts/data/datasources/contacts_from_device_source_data.dart';
import 'features/contacts/domain/repository/contacts_repostiory.dart';
import 'features/contacts/domain/usecases/get_contacts.dart';
import 'features/contacts/presentation/bloc/contacts_bloc.dart';

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
//
  sl.registerFactory(() => AuthBloc(
        login: sl(),
        logout: sl(),
      ));

  sl.registerFactory(() => ContactsBloc(
        getContacts: sl(),
      ));

  sl.registerFactory(() => ChatBloc(
        getConversation: sl(),
        sendMessage: sl(),
      ));

  sl.registerFactory(() => SearchBloc(
        search: sl(),
      ));

  sl.registerFactory(() => ChatsListBloc(
        getChatsList: sl(),
      ));

// Use cases

  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => GetContacts(sl()));
  sl.registerLazySingleton(() => GetConversation(sl()));
  sl.registerLazySingleton(() => SendMessage(sl()));
  sl.registerLazySingleton(() => Search(sl()));
  sl.registerLazySingleton(() => GetChatsList(sl()));

// Repository

  sl.registerLazySingleton<FirebaseAuthRepository>(
      () => FirebaseAuthRepositoryImpl(sl()));
  sl.registerLazySingleton<ContactsRepository>(
      () => ContactsRepositoryImpl(sl()));
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));
  sl.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl(sl()));
  sl.registerLazySingleton<ChatListRepository>(
      () => ChatListRepositoryImpl(sl()));

// Data sources

  sl.registerLazySingleton<FirebaseAuthRemoteDataSource>(
      () => FirebaseAuthRemoteDataSourceImpl(auth: sl()));
  sl.registerLazySingleton<ContactsFromDeviceSourceData>(
      () => ContactsFromDeviceSourceDataImpl());
  sl.registerLazySingleton<ChatDataSource>(
      () => ChatDataSourceImpl(firebase: sl()));
  sl.registerLazySingleton<SearchDataSource>(() => SearchDataSourceImpl(
        firestore: sl(),
      ));
  sl.registerLazySingleton<ChatListDataSource>(
      () => ChatListDataSourceImpl(firestore: sl()));

// Externals

  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
