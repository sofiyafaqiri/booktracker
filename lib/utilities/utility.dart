import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatDate(Timestamp timestamp) {
  return DateFormat.yMMMd().format(timestamp.toDate());
}

double parseDouble(dynamic value) {
  try {
    if (value is int) {
      return double.parse(value.toString());
    } else if (value is double) {
      return value;
    } else {
      return 0.0;
    }
  } catch (e) {
    return null;
  }
}
