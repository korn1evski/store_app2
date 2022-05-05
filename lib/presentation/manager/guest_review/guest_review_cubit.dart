import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

part 'guest_review_state.dart';

class GuestReviewCubit extends Cubit<GuestReviewState> {
  GuestReviewCubit()
      : super(GuestReviewInitial());

  late String status;
  final ImagePicker _picker = ImagePicker();
  late var response;
  Dio dio = new Dio();

  void setReview(int review) {
    emit(UpdateReviewPageState(review: review));
  }

  void loadingReview(){
    emit(LoadingReviewState());
  }

  void toInitial(){
    emit(GuestReviewInitial());
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemp = File(image.path);
      emit(ProvideImageState(image: imageTemp));
    } on PlatformException catch (e) {
      print('Error');
    }
  }

  Future takePhoto() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return;
      }
      final imageTemp = File(image.path);
      emit(ProvideImageState(image: imageTemp));
    } on PlatformException catch (e) {
      print('Error');
    }
  }
}
