import 'package:book_tracker/screens/get_started_page.dart';
import 'package:book_tracker/screens/login_page.dart';
import 'package:book_tracker/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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

  runApp(const MyApp());
}

bool isUserLoggedIn() {
  User? currentUser = FirebaseAuth.instance.currentUser;
  print('currentUser $currentUser');
  return currentUser == null ? false : true;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // User? firebaseUser = FirebaseAuth.instance.currentUser;
    // Widget widget;
    // if (firebaseUser != null) {
    //   print(firebaseUser.email);
    //   widget = MainScreenPage();
    // } else {
    //   widget = LoginPage();
    // }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookTracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isUserLoggedIn() ? MainScreenPage() : LoginPage(),
    );
  }
}
