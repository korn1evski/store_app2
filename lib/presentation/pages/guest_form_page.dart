
import 'package:flutter/material.dart';

class GuestFormPage extends StatelessWidget {
  const GuestFormPage({Key? key, required this.productId}) : super(key: key);
  final int productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Guest form page'),
      ),
    );
  }
}
