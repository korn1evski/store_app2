
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class FormFieldName extends StatelessWidget {
  const FormFieldName({Key? key, required this.target, required this.controller}) : super(key: key);
  final String target;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: target),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your $target';
        } else if (!isAlpha(value)) {
          return '$target should contain only letters';
        } else {
          return null;
        }
      },
    );
  }
}
