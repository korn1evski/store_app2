import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'review_page_state.dart';

class ReviewPageCubit extends Cubit<ReviewPageState> {
  ReviewPageCubit() : super(ReviewPageInitial());

  int starsReview = -1;

  void setReview(int review, int textLength) {
    starsReview = review;
    emit(UpdateReviewPageState(review: review, textLength: textLength));
  }

  void changeText(int textLength){
    emit(UpdateReviewPageState(review: starsReview, textLength: textLength));
  }


  void toInit(){
    emit(ReviewPageInitial());
  }
}
