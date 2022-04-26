
import 'package:flutter/material.dart';

class FavoriteCircle extends StatelessWidget {

  final double size;
  final double iconSize;
  final Color backColor;
  final IconData icon;
  final Color iconColor;

  const FavoriteCircle({this.iconSize = 16, this.size = 25, this.backColor = Colors.white, this.icon = Icons.star_outline, Key? key, this.iconColor = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(25)
        ),
        child: Center(
            child: Icon(icon, size: iconSize, color: iconColor),
        ),
      ),
    );
  }
}
