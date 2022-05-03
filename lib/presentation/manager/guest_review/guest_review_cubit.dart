import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'guest_review_state.dart';

class GuestReviewCubit extends Cubit<GuestReviewState> {
  GuestReviewCubit() : super(GuestReviewInitial());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void initAction(){
    emit(InitGuestState(formKey: _formKey));
  }
}
