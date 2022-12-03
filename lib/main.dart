import 'package:book_tracker/utilities/constant.dart';
import 'package:book_tracker/screens/get_started_page.dart';
import 'package:book_tracker/screens/login_screen.dart';
import 'package:book_tracker/screens/main_screen.dart';
import 'package:book_tracker/screens/page_not_found.dart';
import 'package:book_tracker/utilities/route_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool isUserLoggedIn = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: kFirebaseOptions);

  isUserLoggedIn =
      await FirebaseAuth.instance.currentUser != null ? true : false;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>(
          initialData: null,
          create: (context) => FirebaseAuth.instance.authStateChanges(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BookTracker',
        routes: {
          '/': (context) => LoginPage(),
          '/main': (context) => MainScreenPage(),
          '/login': (context) => LoginPage()
        },
        initialRoute: isUserLoggedIn ? '/main' : '/',
        onGenerateRoute: (settings) {
          print(settings.name);
          return MaterialPageRoute(
            builder: (context) {
              return RouteController(settingName: settings.name);
            },
          );
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return PageNotFound();
            },
          );
        },
      ),
    );
  }
}
