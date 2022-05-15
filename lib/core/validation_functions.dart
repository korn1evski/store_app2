import 'package:flutter/material.dart';

String? simpleValid(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter your full name';
  }
}

String? fullNameValid(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter your full name';
  } else if(value.trim().split(' ').length != 2){
    return 'Your first name and last name should be split by a space';
  }
}


String? emailValid(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter your email';
  } else if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return 'We need your real one!';
  }
}

String? passValid(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter password';
  } else if (value.length < 6) {
    return 'Your password should have at least 6 characters';
  } else if (!value.contains(new RegExp(r'[A-Z]'))) {
    return 'Your password should include at least one capital letter';
  } else if (!value.contains(new RegExp(r'[0-9]'))) {
    return 'Your password should include at least one digit';
  }
}

String? repeatPassValid(String? value, TextEditingController controller) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter password';
  } else if(value != controller.text){
    return 'Passwords don\'t match';
  }
}

String? phoneValid(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Plase enter your phone';
  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    return 'Your phone number should contain only digits';
  } else if(value.length < 8){
    return 'Phone number should consist minimum of 8 digits';
  }
}