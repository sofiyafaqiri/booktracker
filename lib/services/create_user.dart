import 'package:book_tracker/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> createUser(String displayName, BuildContext context) async {
  final userCollection = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid;
  BookUser user = BookUser(
      displayName: displayName,
      uid: uid,
      id: '',
      quote: '',
      profession: '',
      avatarUrl: '');

  userCollection.add(user.toMap());
  return;
}
