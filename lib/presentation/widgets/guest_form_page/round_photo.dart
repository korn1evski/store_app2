
import 'dart:io';

import 'package:flutter/material.dart';

class RoundPhoto extends StatelessWidget {
  const RoundPhoto({Key? key, required this.isFlutter, this.image}) : super(key: key);

  final File? image;
  final bool isFlutter;

  @override
  Widget build(BuildContext context) {
    if(isFlutter){
      return ClipRRect(
        borderRadius: BorderRadius.circular(80),
        child: FlutterLogo(
          size: 160,
        )
      );
    } else {
      return ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: Image.file(
            image!,
            width: 160,
            height: 160,
            fit: BoxFit.cover,
          ));
    }
  }
}

