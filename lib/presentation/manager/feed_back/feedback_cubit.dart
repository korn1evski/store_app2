import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit() : super(FeedbackInitial());

  int starsReview = -1;
  int textLength = 0;

  void setStars(int value){
    starsReview = value;
    emit(FeedBackRefreshState(starsCount: value, textLength: textLength));
  }

  void setTextLength(int value){
    textLength = value;
    emit(FeedBackRefreshState(textLength: value, starsCount: starsReview));
  }

  void loading(bool value){
    starsReview = -1;
    textLength = 0;
    emit(FeedBackIsLoadingState(isLoading: value));
  }
}
