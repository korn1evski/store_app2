import 'package:flutter/material.dart';

import '../../../core/colors.dart';

class TextArea extends StatelessWidget {
  const TextArea(
      {Key? key,
      required this.starsReview,
      required this.maxCharacters,
      required this.textarea,
      required this.onChanged,
      this.hintText = 'Would you like to write anything about this product?'
      })
      : super(key: key);
  final int starsReview;
  final int maxCharacters;
  final TextEditingController textarea;
  final void Function(String) onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      maxLength: maxCharacters,
      controller: textarea,
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      decoration: InputDecoration(
        counterText: '',
        hintText: hintText,
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColors.grey3)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColors.grey3)),
      ),
    );
  }
}
