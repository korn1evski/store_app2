part of 'guest_review_cubit.dart';

abstract class GuestReviewState extends Equatable {
  const GuestReviewState();
}

class GuestReviewInitial extends GuestReviewState {
  GuestReviewInitial({required this.visible});
  final bool visible;
  @override
  List<Object> get props => [visible];
}

class InitGuestState extends GuestReviewState {
  final GlobalKey<FormState> formKey;
  InitGuestState({required this.formKey});
  @override
  List<Object> get props => [formKey];
}

class UpdateReviewPageState extends GuestReviewState {
  int review;
  UpdateReviewPageState({required this.review});
  @override
  List<Object> get props => [review];
}

class ProvideImageState extends GuestReviewState {
  final File image;
  final String link;
  ProvideImageState({required this.image, required this.link});
  @override
  List<Object> get props => [image, link];
}

class LoadingReviewState extends GuestReviewState {

  @override
  List<Object> get props => [];
}

