import 'package:artfolio/auth/auth.dart';
import 'package:artfolio/auth/login_or_register.dart';
import 'package:artfolio/firebase_options.dart';
import 'package:artfolio/screens/user_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      // insert routes to navigate from drawer
      routes: {
        '/login_register_page': (context) => const LoginOrRegister(),
        '/user_page': (context) => UserPage(),
      },
    );
  }
}
