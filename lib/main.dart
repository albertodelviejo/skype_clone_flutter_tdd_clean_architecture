import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Skype Clone',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => MainPage(),
          '/chat': (context) => ChatPage()
        },
      ),
    );
  }
}
