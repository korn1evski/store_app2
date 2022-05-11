part of 'review_page_cubit.dart';

abstract class ReviewPageState extends Equatable {
  const ReviewPageState();
}

class ReviewPageInitial extends ReviewPageState {
  @override
  List<Object> get props => [];
}

class UpdateReviewPageState extends ReviewPageState {
  int review;
  int textLength;
  UpdateReviewPageState({required this.review, required this.textLength});
  @override
  List<Object> get props => [review, textLength];
}
