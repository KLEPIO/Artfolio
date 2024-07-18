import 'package:artfolio/auth/auth.dart';
import 'package:artfolio/auth/login_or_register.dart';
import 'package:artfolio/screens/user_page.dart';
import 'package:artfolio/screens/home_page.dart';
import 'package:artfolio/screens/artist_profile_page.dart';
import 'package:artfolio/screens/artwork_details_page.dart';
import 'package:artfolio/screens/upload_artwork_page.dart';
import 'package:artfolio/screens/explore_discover_page.dart';
import 'package:artfolio/screens/messages_page.dart';
import 'package:artfolio/firebase_options.dart';
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
      // Remove the home property
      // home: const AuthPage(),
      // Define initial route
      initialRoute: '/',
      routes: {
        '/login_register_page': (context) => const LoginOrRegister(),
        '/user_page': (context) => UserPage(),
        '/': (context) => const AuthPage(),
        '/artist_profile': (context) => ArtistProfilePage(),
        '/artwork_details': (context) => ArtworkDetailsPage(),
        '/upload_artwork': (context) => UploadArtworkPage(),
        '/explore_discover': (context) => ExploreDiscoverPage(),
        '/messages': (context) => MessagesPage(),
      },
    );
  }
}
