import 'package:flutter/material.dart';

import '../../../core/colors.dart';

class SimpleInput extends StatelessWidget {
  const SimpleInput({Key? key, required this.controller, required this.validationFunc, required this.hintText}) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validationFunc;

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(width: 1, color: AppColors.grey3)),
        border: OutlineInputBorder(
            borderSide:
            BorderSide(width: 1, color: AppColors.grey3)),
        focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(width: 1, color: AppColors.grey3)),
      ),
      validator: validationFunc,
      style: TextStyle(
          fontSize: 14
      ),
    );
  }
}
