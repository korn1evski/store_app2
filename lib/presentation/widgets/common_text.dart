
import 'dart:ui';

import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String text;
  final String font;
  final double size;
  final Color color;
  final int numberOfLines;
  final bool center;
  final double lineHeight;
  const CommonText({Key? key, required this.text, this.font = 'SFPRODISPLAYREGULAR', required this.size, this.color = Colors.black, this.numberOfLines = 20, this.center = false, this.lineHeight = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: numberOfLines,
      textAlign: center ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        fontFamily: font,
        fontSize: size,
        color: color,
        height: lineHeight,
      ),
    );
  }
}
