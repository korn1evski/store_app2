

import 'package:flutter/material.dart';

import '../../core/colors.dart';
import 'common_text.dart';

class AddButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final void Function()? onTap;
  const AddButton({Key? key, required this.text, this.width = 146 , this.height = 50, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.green1,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(child: CommonText(text: text, size: 14, color: Colors.white))
      ),
    );
  }
}
