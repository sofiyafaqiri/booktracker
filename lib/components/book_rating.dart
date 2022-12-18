import 'package:book_tracker/utilities/constant.dart';
import 'package:flutter/material.dart';

class BookRating extends StatelessWidget {
  final double? score;

  const BookRating({Key? key, this.score}) : super(key: key);

  IconData getRatingIcon() {
    return score == 0
        ? Icons.star_border
        : (score! > 4.5 ? Icons.star : Icons.star_half);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                offset: Offset(3, 7),
                blurRadius: 20,
                color: Color(0xFD3D3D3).withOpacity(0.5)),
          ]),
      child: Row(
        children: [
          Icon(getRatingIcon(), color: kIconColor, size: 15),
          SizedBox(
            width: 8,
          ),
          Text(
            '$score',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
    // return Container(
    //   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
    //   decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(16),
    //       boxShadow: [
    //         BoxShadow(
    //             offset: Offset(3, 7),
    //             blurRadius: 20,
    //             color: Color(0xFD3D3D3).withOpacity(0.5)),
    //       ]),
    //   child: Column(
    //     children: [
    //       Icon(Icons.star, color: kIconColor, size: 15),
    //       SizedBox(
    //         height: 5,
    //       ),
    //       Text(
    //         '$score',
    //         style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    //       )
    //     ],
    //   ),
    // );
  }
}
