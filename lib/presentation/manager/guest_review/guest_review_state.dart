part of 'guest_review_cubit.dart';

abstract class GuestReviewState extends Equatable {
  const GuestReviewState();
}

class GuestReviewInitial extends GuestReviewState {
  @override
  List<Object> get props => [];
}

class InitGuestState extends GuestReviewState {
  final GlobalKey<FormState> formKey;
  InitGuestState({required this.formKey});
  @override
  List<Object> get props => [formKey];
}
