import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/use_cases/upload_image_usecase.dart';

part 'guest_review_state.dart';

class GuestReviewCubit extends Cubit<GuestReviewState> {
  GuestReviewCubit({required this.uploadImageUseCase})
      : super(GuestReviewInitial(visible: false));
  final UploadImageUseCase uploadImageUseCase;
  String? imageLink;

  late String status;
  final ImagePicker _picker = ImagePicker();
  late var response;

  void setReview(int review) {
    emit(UpdateReviewPageState(review: review));
  }

  void loadingReview(){
    emit(LoadingReviewState());
  }

  void upgradeInitial(bool visible){
    emit(GuestReviewInitial(visible: visible));
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemp = File(image.path);
      imageLink = await uploadImageUseCase.call(imageTemp);
      imageLink ??= 'string';
      emit(ProvideImageState(image: imageTemp, link: imageLink!));
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
      imageLink = await uploadImageUseCase.call(imageTemp);
      imageLink ??= 'string';
      emit(ProvideImageState(image: imageTemp, link: imageLink!));
    } on PlatformException catch (e) {
      print('Error');
    }
  }
}
