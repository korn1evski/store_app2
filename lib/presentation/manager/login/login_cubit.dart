import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/domain/use_cases/login_usecase.dart';
import 'package:store_app/domain/use_cases/set_shared_string_usecase.dart';
import 'package:store_app/injection_container.dart' as di;
import 'package:store_app/presentation/pages/nav_page.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUseCase, required this.setSharedStringUseCase}) : super(LoginInitial());

  final LoginUseCase loginUseCase;
  final SetSharedStringUseCase setSharedStringUseCase;
  
  Future<void> login(String email, String password, BuildContext context) async{
    List<String> result = await loginUseCase.call(email, password);
    String message = '';
    if(result.length == 1){
      message = result[0];
    } else {
      setSharedStringUseCase.call('refreshToken', result[0]);
      setSharedStringUseCase.call('accessToken', result[1]);
      Navigator.push(context, MaterialPageRoute(builder: (context) => NavPage()));
    }
    emit(LoginFinishedState(message: message));
  }

  void loginLoading(){
    emit(LoginLoading());
  }

}
