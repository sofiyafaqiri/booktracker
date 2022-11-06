import 'package:book_tracker/model/book.dart';
import 'package:book_tracker/screens/book_search_page.dart';
import 'package:book_tracker/screens/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../widget/create_profile.dart';

class MainScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    CollectionReference bookCollectionReference =
        FirebaseFirestore.instance.collection('books');
    List<Book> userBooksReadList = [];

    // var authUser = Provider.of<User>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: userCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final userListStream = snapshot.data!.docs.map((user) {
            return MUser.fromDocument(user);
          }).where((user) {
            return (user.uid == FirebaseAuth.instance.currentUser!.uid);
          }).toList(); //
          MUser curUser = userListStream[0];
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white24,
              elevation: 0.0,
              centerTitle: false,
              title: Row(
                children: [
                  Text(
                    curUser.displayName,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.redAccent, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                Column(
                  children: [
                    InkWell(
                      child: CircleAvatar(
                        radius: 19,
                        backgroundImage: NetworkImage(curUser.avatarUrl != null
                            ? curUser.avatarUrl
                            : 'http://i.pravatar.cc/300'),
                        backgroundColor: Colors.white,
                        child: Text(''),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            // return createProfileMobile(context, userListStream,
                            //     FirebaseAuth.instance.currentUser, null);
                            return createProfileDialog(
                                context, curUser, userBooksReadList);
                          },
                        );
                      },
                    ),
                    Text(
                      '${curUser.displayName}',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
                TextButton.icon(
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        return Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      });
                    },
                    icon: Icon(Icons.logout),
                    label: Text(''))
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookSearchPage(),
                    ));
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.redAccent,
            ),
          );
        });
  }
}
