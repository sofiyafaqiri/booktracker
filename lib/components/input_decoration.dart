import 'package:book_tracker/utilities/constant.dart';
import 'package:flutter/material.dart';

InputDecoration buildInputDecoration({String label, String hintText}) {
  return InputDecoration(
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: kIconColor, width: 2)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.purple, width: 2.0)),
      labelText: label,
      labelStyle: TextStyle(color: Colors.black),
      hintText: hintText);
}
