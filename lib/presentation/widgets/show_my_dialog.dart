import 'package:flutter/material.dart';

dynamic showMyDialog(BuildContext context, String alertText, String content, String ok, Color buttonColor){
  return  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(alertText),
      content: Text(content),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: buttonColor),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(ok))
      ],
    ),
  );
}
