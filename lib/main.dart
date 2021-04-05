import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chats_list/presentation/bloc/chats_list_bloc.dart';
import 'features/search/presentation/bloc/search_bloc.dart';
import 'features/search/presentation/pages/search_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/chat/presentation/pages/chat_page.dart';
import 'features/contacts/presentation/bloc/bloc.dart';
import 'features/contacts/presentation/pages/main_page.dart';

import 'injection_container.dart' as di;
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ContactsBloc>(),
        ),
        BlocProvider(create: (context) => sl<SearchBloc>()),
        BlocProvider(create: (context) => sl<ChatsListBloc>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Skype Clone',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        onGenerateRoute: (settings) {
          final args = settings.arguments;
          switch (settings.name) {
            case '/chat':
              return MaterialPageRoute(builder: (_) => ChatPage(data: args));
          }
        },
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => MainPage(),
          '/search': (context) => SearchPage(),
        },
      ),
    );
  }
}
