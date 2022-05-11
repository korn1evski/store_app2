import 'package:flutter/material.dart';

import '../../../core/colors.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput(
      {Key? key, required this.controller, required this.hintText, this.validationFunc})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validationFunc;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isHidden = true;

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isHidden,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: IconButton(icon: isHidden
            ? Icon(Icons.visibility_off)
            : Icon(Icons.visibility), onPressed: togglePasswordVisibility,),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        hintText: widget.hintText,
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
      validator: widget.validationFunc,
      keyboardType: TextInputType.visiblePassword,
      autofillHints: [AutofillHints.password],
      style: TextStyle(
          fontSize: 14
      ),
    );
  }
}
