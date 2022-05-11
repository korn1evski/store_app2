import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/colors.dart';
import '../../manager/review_page/review_page_cubit.dart';

class TextArea extends StatelessWidget {
  TextArea({Key? key, required this.starsReview, required this.maxCharacters, required this.textarea}) : super(key: key);
  int starsReview;
  final int maxCharacters;
  TextEditingController textarea;

  @override
  Widget build(BuildContext context) {
    return  TextField(
      onChanged: (value) {
        BlocProvider.of<ReviewPageCubit>(context)
            .changeText(value.length);
      },
      maxLength: maxCharacters,
      controller: textarea,
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      decoration: InputDecoration(
        counterText: '',
        hintText:
        'Would you like to write anything about this product?',
        border: OutlineInputBorder(
            borderSide:
            BorderSide(width: 1, color: AppColors.grey3)),
        focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(width: 1, color: AppColors.grey3)),
      ),
    );
  }
}
