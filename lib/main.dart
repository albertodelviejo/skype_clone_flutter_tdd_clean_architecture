import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/contacts/presentation/pages/main_page.dart';

import 'features/auth/presentation/pages/login_page.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skype Clone',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => MainPage(),
      },
    );
  }
}
