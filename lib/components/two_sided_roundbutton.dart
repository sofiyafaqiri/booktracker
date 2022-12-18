import 'dart:io';

import 'package:book_tracker/utilities/constant.dart';
import 'package:flutter/material.dart';

class TwoSidedRoundeButton extends StatelessWidget {
  final String? text;
  final double? radius;
  final VoidCallback? press;
  final Color? color;

  const TwoSidedRoundeButton(
      {Key? key,
      this.text,
      this.radius = 30,
      this.press,
      this.color = kBlackColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? isMobile = null;
    try {
      isMobile = (Platform.isIOS || Platform.isAndroid);
    } catch (e) {
      isMobile = false;
    }

    return GestureDetector(
        onTap: press,
        child: Container(
          width: !isMobile ? (text!.length * 8) + 32 as double : null,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: this.color,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radius!),
                  bottomRight: Radius.circular(radius!))),
          child: Text(text!, style: TextStyle(color: Colors.white)),
        ));
  }
}
