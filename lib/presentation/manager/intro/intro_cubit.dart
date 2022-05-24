import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app/domain/use_cases/get_shared_string_usecase.dart';
import 'package:store_app/domain/use_cases/set_shared_string_usecase.dart';
import 'package:store_app/domain/use_cases/verify_login_usecase.dart';

import '../../pages/login_page.dart';

part 'intro_state.dart';

class IntroCubit extends Cubit<IntroState> {
  IntroCubit(
      {required this.verifyLoginUseCase,
      required this.setSharedStringUseCase,
      required this.getSharedStringUseCase})
      : super(IntroInitial());

  final VerifyLoginUseCase verifyLoginUseCase;
  final GetSharedStringUseCase getSharedStringUseCase;
  final SetSharedStringUseCase setSharedStringUseCase;

  Future<void> verifyLogin(BuildContext context) async {
    try {
      final refreshToken = getSharedStringUseCase.call('refreshToken');
      if (refreshToken != null) {
        emit(IntroLoadingState());
        String result = await verifyLoginUseCase.call(refreshToken);
        if (result == '') {
          emit(IntroErrorLoadedState());
        } else {
          await setSharedStringUseCase.call('accessToken', result);
          emit(IntroLoadedState());
        }
      } else {
        emit(IntroElseState());
      }
    } on SocketException catch (_) {
      final accessToken = getSharedStringUseCase.call('accessToken');
      final refreshToken = getSharedStringUseCase.call('refreshToken');
      if(accessToken != null && accessToken != '' && refreshToken != null && refreshToken != ''){
        emit(IntroLoadedState());
      } else {
        emit(IntroErrorLoadedState());
      }
    }
  }
}
