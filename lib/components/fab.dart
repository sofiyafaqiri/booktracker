import 'package:book_tracker/screens/search_screen.dart';
import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  const FAB({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookSearchPage(),
            ));
      },
      backgroundColor: Colors.redAccent,
      child: const Icon(Icons.add),
    );
  }
}
