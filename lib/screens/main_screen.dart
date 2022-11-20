import 'dart:io';

import 'package:book_tracker/components/loading_indicator.dart';
import 'package:book_tracker/components/main_appbar.dart';
import 'package:book_tracker/models/book_model.dart';
import 'package:book_tracker/components/book_details_dialog.dart';
import 'package:book_tracker/components/reading_list_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utilities/constant.dart';
import '../models/user_model.dart';
import '../components/fab.dart';

class MainScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isMobile;
    try {
      isMobile = (Platform.isIOS || Platform.isAndroid);
    } catch (e) {
      isMobile = false;
    }

    print('DPR ${MediaQuery.of(context).devicePixelRatio}');
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    CollectionReference bookCollectionReference =
        FirebaseFirestore.instance.collection('books');
    List<Book> userBooksReadList = [];
    var authUser = Provider.of<User>(context);
    // var authUser = Provider.of<User>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: userCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }
          final userListStream = snapshot.data.docs.map((user) {
            return BookUser.fromDocument(user);
          }).where((user) {
            return (user.uid == FirebaseAuth.instance?.currentUser?.uid);
          }).toList(); //
          BookUser curUser = userListStream[0];
          return Scaffold(
            appBar: MainAppbar(
                curUser: curUser, userBooksReadList: userBooksReadList),
            floatingActionButton: FAB(),
            body: SingleChildScrollView(
              child: SizedBox(
                height:
                    MediaQuery.of(context).size.height + (isMobile ? 0 : 80),
                child: Column(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 12, left: 12, bottom: 10),
                      width: double.infinity,
                      child: RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.headline5,
                              children: [
                            TextSpan(
                              text: 'Now Reading',
                              style: TextStyle(
                                  color: kBlackColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            // TextSpan(
                            //     text: 'right now...',
                            //     style: TextStyle(fontWeight: FontWeight.bold))
                          ])),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (authUser != null)
                        ? StreamBuilder<QuerySnapshot>(
                            stream: bookCollectionReference.snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              var userBookFilteredReadListStream =
                                  snapshot.data.docs.map((book) {
                                return Book.fromDocument(book);
                              }).where((book) {
                                return (book.userId == authUser.uid) &&
                                    (book.finishedReading == null) &&
                                    (book.startedReading != null);
                              }).toList();

                              userBooksReadList =
                                  snapshot.data.docs.map((book) {
                                return Book.fromDocument(book);
                              }).where((book) {
                                return (book.userId == authUser.uid) &&
                                    (book.finishedReading != null) &&
                                    (book.startedReading != null);
                              }).toList();
                              //  booksRead = userBooksReadList.length;
                              // print(
                              //     'read list ${userBookFilteredReadListStream.length}');
                              // print('book length ${userBooksReadList.length}');
                              return Expanded(
                                flex: 1,
                                child: (userBookFilteredReadListStream.length >
                                        0)
                                    ? ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            userBookFilteredReadListStream
                                                .length,
                                        itemBuilder: (context, index) {
                                          Book book =
                                              userBookFilteredReadListStream[
                                                  index];

                                          return InkWell(
                                            // child: NewReadingListCard(
                                            //   rating: book.rating != null
                                            //       ? (book.rating)
                                            //       : 4.0,
                                            //   buttonText: 'Reading',
                                            //   title: book.title,
                                            //   author: book.author,
                                            //   image: book.photoUrl,
                                            // ),
                                            child: ReadingListCard(
                                              rating: book.rating != null
                                                  ? (book.rating)
                                                  : 4.0,
                                              buttonText: 'Reading',
                                              title: book.title,
                                              author: book.author,
                                              image: book.photoUrl,
                                            ),
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return BookDetailsDialog(
                                                    book: book,
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      )
                                    : const Center(
                                        child: Text(
                                            'You haven\'t started reading. \nStart by adding a book.',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ))),
                              );
                            },
                          )
                        : Container(),
                    Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Reading List',
                                    style: TextStyle(
                                        color: kBlackColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold))
                              ])),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    (authUser != null)
                        ? StreamBuilder<QuerySnapshot>(
                            stream: bookCollectionReference.snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              var readingListListBook =
                                  snapshot.data.docs.map((book) {
                                return Book.fromDocument(book);
                              }).where((book) {
                                return (book.userId == authUser.uid) &&
                                    (book.finishedReading == null) &&
                                    (book.startedReading == null);
                              }).toList();

                              return Expanded(
                                  flex: 1,
                                  child: (readingListListBook.length > 0)
                                      ? ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: readingListListBook.length,
                                          itemBuilder: (context, index) {
                                            Book book =
                                                readingListListBook[index];

                                            return InkWell(
                                              child: ReadingListCard(
                                                  buttonText: 'Not Started',
                                                  rating: book.rating != null
                                                      ? (book.rating)
                                                      : 4.0,
                                                  author: book.author,
                                                  image: book.photoUrl,
                                                  title: book.title),
                                              onTap: () => showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    BookDetailsDialog(
                                                        book: book),
                                              ),
                                            );
                                          },
                                        )
                                      : Center(
                                          child: Text(
                                              'No books found. Add a book :)',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ))));
                            },
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          );
        });
  }
}
