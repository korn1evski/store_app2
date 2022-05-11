import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/domain/entities/account_info_entity.dart';
import 'package:store_app/domain/use_cases/get_account_info.dart';
import 'package:store_app/domain/use_cases/verify_login_usecase.dart';
import 'package:store_app/injection_container.dart' as di;
import 'package:store_app/presentation/pages/intro_page.dart';
part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit({required this.verifyLoginUseCase, required this.getAccountInfoUseCase}) : super(AccountInitial());

  final VerifyLoginUseCase verifyLoginUseCase;
  final GetAccountInfoUseCase getAccountInfoUseCase;
  final prefs = di.sl<SharedPreferences>();

  Future<void> loadAccountPage() async{
    emit(AccountPageLoadingState());
    String result = await verifyLoginUseCase.call(prefs.getString('refreshToken')!);
    if(result == ''){
      emit(AccountPageErrorState());
    } else {
      await prefs.setString('accessToken', result);
      final AccountInfoEntity accountInfoEntity = await getAccountInfoUseCase.call(prefs.getString('accessToken')!);
      if(accountInfoEntity.id == -1){
        emit(AccountPageErrorState());
      } else {
        emit(AccountPageLoadedState(fullName: accountInfoEntity.fullName, email: accountInfoEntity.email, phoneNumber: accountInfoEntity.phoneNumber));
      }
    }
  }

  Future<void>logOut(BuildContext context) async{
    await prefs.setString('refreshToken', '');
    await prefs.setString('accessToken', '');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => IntroPage()));
  }

}
