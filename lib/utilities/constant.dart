import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

const kFirebaseOptions = FirebaseOptions(
    apiKey: "AIzaSyCnME4FjG1kwXm9RTe5nREkTGVN7F2U_z8",
    authDomain: "booktrackerapp-e3672.firebaseapp.com",
    projectId: "booktrackerapp-e3672",
    storageBucket: "booktrackerapp-e3672.appspot.com",
    messagingSenderId: "360066158335",
    appId: "1:360066158335:web:961e38061928c4abadc6ca",
    measurementId: "G-558W804S1S");

const kBlackColor = Color(0xFF393939);
const kLightBlackColor = Color(0xFF8F8F8F);
const kIconColor = Color(0xFFF48A37);
const kReadingCardBg = Color(0xFFFBF7FD);
const kProgressIndicator = Color(0xFFBE7066);
const kButtonColor = Color(0xFFBE7066);
const kCardBgColor = Colors.white;

const kLightPurple = Color(0xBA68C8d4);

final kShadowColor = Color(0xFFD3D3D3).withOpacity(.84);

var kLoginButtonStyle = TextButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    backgroundColor: kIconColor,
    textStyle: const TextStyle(fontSize: 18));
