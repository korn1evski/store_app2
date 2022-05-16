part of 'feedback_cubit.dart';

abstract class FeedbackState extends Equatable {
  const FeedbackState();
}

class FeedbackInitial extends FeedbackState {
  @override
  List<Object> get props => [];
}

class FeedBackRefreshState extends FeedbackState {
  final textLength;
  final starsCount;
  const FeedBackRefreshState({required this.textLength, required this.starsCount});
  @override
  List<Object> get props => [textLength, starsCount];
}

class FeedBackIsLoadingState extends FeedbackState {
  final isLoading;
  FeedBackIsLoadingState({required this.isLoading});
  @override
  List<Object> get props => [isLoading];
}
