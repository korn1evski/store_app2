import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/domain/use_cases/register_user_usecase.dart';
import 'package:store_app/presentation/manager/login/login_cubit.dart';

import '../../../domain/use_cases/upload_image_usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.registerUserUseCase, required this.uploadImageUseCase}) : super(RegisterInitial());

  final RegisterUserUseCase registerUserUseCase;
  final UploadImageUseCase uploadImageUseCase;
  String? imageLink;

  Future<void> registerUser(String fullName, String email, String phoneNumber, String password, BuildContext context) async{
    imageLink ??= 'string';
    int result = await registerUserUseCase.call(fullName, email, phoneNumber, password, imageLink!);
    if(result == 201){
      BlocProvider.of<LoginCubit>(context).login(email, password, context);
    } else {
      emit(RegistrationState(message: 'User with this email already exists'));
    }
  }

  void toInitial(){
    emit(RegisterInitial());
  }

  void registerLoading(){
    emit(RegistrationLoadingState());
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
      emit(ProvideRegisterImageState(image: imageTemp, link: imageLink!));
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
      emit(ProvideRegisterImageState(image: imageTemp, link: imageLink!));
    } on PlatformException catch (e) {
      print('Error');
    }
  }
}
