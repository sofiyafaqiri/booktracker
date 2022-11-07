import 'package:book_tracker/screens/get_started_page.dart';
import 'package:book_tracker/screens/login_page.dart';
import 'package:book_tracker/screens/main_screen.dart';
import 'package:book_tracker/screens/page_not_found.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool isUserLoggedIn = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCnME4FjG1kwXm9RTe5nREkTGVN7F2U_z8",
        authDomain: "booktrackerapp-e3672.firebaseapp.com",
        projectId: "booktrackerapp-e3672",
        storageBucket: "booktrackerapp-e3672.appspot.com",
        messagingSenderId: "360066158335",
        appId: "1:360066158335:web:961e38061928c4abadc6ca",
        measurementId: "G-558W804S1S"),
  );

  isUserLoggedIn =
      await FirebaseAuth.instance.currentUser != null ? true : false;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final firebaseUser = context.watch<User>();
    // Stream<User>? authState =
    //     FirebaseAuth.instance.authStateChanges() as Stream<User>?;
    print('user logged in $isUserLoggedIn');
    return MultiProvider(
      providers: [
        StreamProvider(
          initialData: User(),
          create: (context) =>
              FirebaseAuth.instance.authStateChanges() as Stream<User>?,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BookTracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // initialRoute: '/',
        routes: {
          '/': (context) => GetStartedPage(),
          '/main': (context) => MainScreenPage(),
          '/login': (context) => LoginPage()
        },
        //home: TesterApp(),
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

class RouteController extends StatelessWidget {
  final String? settingName;

  const RouteController({Key? key, required this.settingName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userSignedIn = Provider.of<User>(context) != null;

    final signedInGotoMain =
        userSignedIn && settingName == '/main'; // they are good to go!
    final notSignedIngotoMain = !userSignedIn &&
        settingName == '/main'; // not signed in user trying to to the mainPage
    if (settingName == '/') {
      return GetStartedPage();
    } else if (settingName == '/login' || notSignedIngotoMain) {
      return LoginPage();
    } else if (signedInGotoMain) {
      return MainScreenPage();
    } else {
      return PageNotFound();
    }
  }
}
