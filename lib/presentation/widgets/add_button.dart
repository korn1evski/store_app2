

import 'package:flutter/material.dart';

import '../../core/colors.dart';
import 'common_text.dart';

class AddButton extends StatelessWidget {
  final String text;
  const AddButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 146,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.green1,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(child: CommonText(text: text, size: 14, color: Colors.white))
    );
  }
}
