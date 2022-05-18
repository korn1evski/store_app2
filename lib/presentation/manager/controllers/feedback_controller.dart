
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/colors.dart';
import '../../widgets/show_my_dialog.dart';
import '../detail_page/detail_page_cubit.dart';

class FeedBackController extends GetxController {
  final TextEditingController textArea = TextEditingController();
  final RxInt starsReview = RxInt(-1);
  final int maxCharacters = 30;
  final isLoading = false.obs;
  final usedCharacters = 0.obs;

  void setStarsReview(int value){
    starsReview.value = value;
  }

  void changeUsedCharacters(int value){
    usedCharacters.value = value;
  }

  void setIsLoading(bool value){
    isLoading.value = value;
  }

  void submitReview(BuildContext context, int productId){
    if (starsReview.value == -1) {
      showMyDialog(context, 'Alert', 'Rate a product',
          'ok', AppColors.green1);
    } else if (textArea.text.trim() == '') {
      showMyDialog(context, 'Alert', 'Write a review',
          'ok', AppColors.green1);
    } else {
      setIsLoading(true);
      BlocProvider.of<DetailPageCubit>(context)
          .prepareReview(
          context: context,
          productId: productId,
          message: textArea.text,
          starsReview: starsReview.value);
    }
  }

  @override
  void onClose(){
    textArea.dispose();
  }
}