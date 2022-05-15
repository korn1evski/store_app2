import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/domain/entities/account_info_entity.dart';
import 'package:store_app/domain/use_cases/get_account_info.dart';
import 'package:store_app/domain/use_cases/get_shared_string_usecase.dart';
import 'package:store_app/domain/use_cases/verify_login_usecase.dart';
import 'package:store_app/presentation/manager/detail_page/detail_page_cubit.dart';

part 'review_page_state.dart';

class ReviewPageCubit extends Cubit<ReviewPageState> {
  ReviewPageCubit() : super(ReviewPageInitial());

  int starsReview = -1;

  void setReview(int review, int textLength) {
    starsReview = review;
    emit(UpdateReviewPageState(review: review, textLength: textLength));
  }

  void changeText(int textLength) {
    emit(UpdateReviewPageState(review: starsReview, textLength: textLength));
  }

  void loading() {
    emit(PositionedLoadingState());
  }

  void toInit() {
    emit(ReviewPageInitial());
  }
}
