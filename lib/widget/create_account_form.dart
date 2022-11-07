import 'package:book_tracker/screens/main_screen.dart';
import 'package:book_tracker/services/create_user.dart';
import 'package:book_tracker/widget/input_decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm({
    Key key,
    GlobalKey<FormState> formKey,
    TextEditingController emailTextController,
    TextEditingController passwordTextController,
  })  : _formKey = formKey,
        _emailTextController = emailTextController,
        _passwordTextController = passwordTextController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailTextController;
  final TextEditingController _passwordTextController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        Text(
            'Please enter a valid email and a password that is at least 6 character.'),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            validator: (value) {
              return value.isEmpty ? 'Please add an email' : null;
            },
            controller: _emailTextController,
            decoration: buildInputDecoration(
                label: 'Enter email', hintText: 'name@gmail.com'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            validator: (value) {
              print('value $value');
              return value.isEmpty ? 'Enter password' : null;
            },
            controller: _passwordTextController,
            obscureText: true,
            decoration: buildInputDecoration(label: 'password', hintText: ''),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
            style: TextButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                backgroundColor: Colors.amber,
                textStyle: TextStyle(fontSize: 18)),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                String email = _emailTextController.text;
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: _passwordTextController.text)
                    .then((value) {
                  if (value.user != null) {
                    String displayName = email.toString().split('@')[0];
                    createUser(displayName, context).then((value) {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) {
                        return Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreenPage(),
                            ));
                      });
                    });
                  }
                });
              }
            },
            child: Text('Create Account'))
      ]),
    );
  }
}
