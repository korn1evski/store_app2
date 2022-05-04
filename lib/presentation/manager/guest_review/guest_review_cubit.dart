import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Img;
import 'package:store_app/domain/use_cases/send_review_usecase.dart';

part 'guest_review_state.dart';

class GuestReviewCubit extends Cubit<GuestReviewState> {
  GuestReviewCubit({required this.sendReviewUseCase}) : super(GuestReviewInitial());
  final SendReviewUseCase sendReviewUseCase;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String status;
  final ImagePicker _picker = ImagePicker();

  void initAction() {
    emit(InitGuestState(formKey: _formKey));
  }

  void setReview(int review) {
    emit(UpdateReviewPageState(review: review));
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

  Future<File> _saveImageToDisk(String path, Directory directory) async {
    try {
      final file = File(path);
      Img.Image image = Img.decodeImage(file.readAsBytesSync())!;
      String imgType = path
          .split('.')
          .last;
      String mPath = '${directory.toString()}/image_${DateTime.now()}.$imgType';
      File dFile = File(mPath);
      if (imgType == 'jpeg' || imgType == 'jpg') {
        dFile.writeAsBytesSync(Img.encodeJpg(image));
      } else {
        dFile.writeAsBytesSync(Img.encodePng(image));
      }
      return dFile;
    } catch(e){
      print('Error');
      return File('');
    }
  }

}
