
import 'package:flutter/material.dart';
import 'package:store_app/core/colors.dart';

class FloatingExt extends StatelessWidget {
  const FloatingExt({Key? key, required this.text, required this.iconData, required this.foo, this.backColor = Colors.lightBlue}) : super(key: key);
  final String text;
  final IconData iconData;
  final Function foo;
  final Color backColor;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: foo(),
      label: Text(
        text,
      ),
      icon: Icon(iconData),
      backgroundColor: backColor,
    );
  }
}
