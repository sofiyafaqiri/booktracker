import 'package:book_tracker/components/signup_form.dart';
import 'package:book_tracker/components/login_form.dart';
import 'package:book_tracker/utilities/constant.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isCreateAccountClicked = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
              // flex: 2,
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.book, color: kIconColor, size: 50),
              SizedBox(height: 18),
              Text(
                'Book Tracker',
                style: TextStyle(fontSize: 30, color: kIconColor),
              )
            ],
          )),
          Text(
            isCreateAccountClicked ? 'Sign Up' : 'Sign In',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  child: isCreateAccountClicked != true
                      ? LoginForm(
                          formKey: _formKey,
                          emailTextController: _emailTextController,
                          passwordTextController: _passwordTextController)
                      : CreateAccountForm(
                          formKey: _formKey,
                          emailTextController: _emailTextController,
                          passwordTextController: _passwordTextController),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.portrait_rounded),
                  style: TextButton.styleFrom(
                      // primary: Colors.red,
                      textStyle: const TextStyle(
                          fontSize: 18, fontStyle: FontStyle.italic)),
                  onPressed: () {
                    setState(() {
                      if (!isCreateAccountClicked) {
                        isCreateAccountClicked = true;
                      } else {
                        isCreateAccountClicked = false;
                      }
                    });
                  },
                  label: Text(isCreateAccountClicked
                      ? 'Already have an account?'
                      : 'Create Account '),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
