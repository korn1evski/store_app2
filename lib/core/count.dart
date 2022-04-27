

import 'package:flutter/material.dart';

class Count {
  static ValueNotifier<int> count = ValueNotifier(10);

  void increment(){
    count.value++;
  }

  void decrement(){
    count.value--;
  }
}