import 'package:book_tracker/components/create_profile.dart';
import 'package:book_tracker/utilities/constant.dart';
import 'package:book_tracker/models/book_model.dart';
import 'package:book_tracker/models/user_model.dart';
import 'package:book_tracker/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainAppbar extends StatelessWidget with PreferredSizeWidget {
  const MainAppbar({
    Key key,
    @required this.curUser,
    @required this.userBooksReadList,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final BookUser curUser;
  final List<Book> userBooksReadList;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(width: 26),
          Icon(Icons.book, color: kIconColor),
        ],
      ),
      title: Text(
        'Book Tracker',
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: kIconColor, fontWeight: FontWeight.bold),
      ),
      actions: [
        InkWell(
          child: CircleAvatar(
            radius: 19,
            backgroundImage:
                NetworkImage(curUser.avatarUrl ?? 'http://i.pravatar.cc/300'),
            backgroundColor: Colors.white,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return createProfileDialog(context, curUser, userBooksReadList);
              },
            );
          },
        ),
        TextButton.icon(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                return Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              });
            },
            icon: Icon(Icons.logout),
            label: Text(''))
      ],
    );
  }
}
