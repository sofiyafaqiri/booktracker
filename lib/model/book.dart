import 'package:book_tracker/constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String? id;
  final String title;
  final String author;
  final String? notes;
  final String photoUrl;
  final String categories;
  final String publishedDate;
  double? rating;
  final String description;
  final int pageCount;
  final Timestamp? startedReading;
  final Timestamp? finishedReading;
  final String? userId;

  Book({
    this.id,
    required this.title,
    required this.author,
    this.notes,
    required this.photoUrl,
    required this.categories,
    required this.publishedDate,
    this.rating,
    required this.description,
    required this.pageCount,
    this.startedReading,
    this.finishedReading,
    this.userId,
  });
  factory Book.fromDocument(QueryDocumentSnapshot data) {
    return Book(
        id: data.id,
        title: data.get('title'),
        author: data.get('author'),
        notes: data.get('notes'),
        photoUrl: data.get('photo_url'),
        categories: data.get('categories'),
        publishedDate: data.get('published_date'),
        rating: parseDouble(data.get('rating'))!,
        description: data.get('description'),
        pageCount: data.get('page_count'),
        startedReading: data.get('started_reading_at'),
        finishedReading: data.get('finished_reading_at'),
        userId: data.get('user_id'));
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'user_id': userId,
      'author': author,
      'notes': notes,
      'photo_url': photoUrl,
      'published_date': publishedDate,
      'rating': rating,
      'description': description,
      'page_count': pageCount,
      'started_reading_at': startedReading,
      'finished_reading_at': finishedReading,
      'categories': categories,
    };
  }
}
