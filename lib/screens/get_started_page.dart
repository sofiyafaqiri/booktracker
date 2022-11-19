import 'package:book_tracker/screens/login_screen.dart';
import 'package:book_tracker/components/input_decoration.dart';
import 'package:book_tracker/components/login_form.dart';
import 'package:flutter/material.dart';

class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CircleAvatar(
        backgroundColor: Colors.black12,
        child: Column(
          children: [
            Spacer(),
            Text(
              'BookTracker',
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              ' "Read. Change. Yourself" ',
              style: TextStyle(
                  color: Colors.black26,
                  fontWeight: FontWeight.bold,
                  fontSize: 29),
            ),
            SizedBox(
              height: 50,
            ),
            TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.deepPurpleAccent.shade200,
                  textStyle: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                },
                icon: Icon(Icons.login_rounded),
                label: Text('Sign in to get started ')),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
