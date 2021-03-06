import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app/domain/entities/account_info_entity.dart';
import 'package:store_app/domain/use_cases/get_account_info.dart';
import 'package:store_app/domain/use_cases/get_shared_string_usecase.dart';
import 'package:store_app/domain/use_cases/set_shared_string_usecase.dart';
import 'package:store_app/domain/use_cases/verify_login_for_account_info_usecase.dart';
import 'package:store_app/domain/use_cases/verify_login_usecase.dart';
import 'package:store_app/presentation/pages/intro_page.dart';
part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit({required this.verifyLoginForAccountInfoUseCase, required this.getAccountInfoUseCase, required this.setSharedStringUseCase, required this.getSharedStringUseCase}) : super(AccountInitial());

  final VerifyLoginForAccountInfoUseCase verifyLoginForAccountInfoUseCase;
  final GetAccountInfoUseCase getAccountInfoUseCase;
  final GetSharedStringUseCase getSharedStringUseCase;
  final SetSharedStringUseCase setSharedStringUseCase;

  Future<void> loadAccountPage() async{
    emit(AccountPageLoadingState());
    String result = await verifyLoginForAccountInfoUseCase.call(getSharedStringUseCase.call('refreshToken')!);
    if(result == ''){
      emit(AccountPageErrorState());
    } else {
      await setSharedStringUseCase.call('accessToken', result);
      final AccountInfoEntity? accountInfoEntity = await getAccountInfoUseCase.call();
      if(accountInfoEntity == null){
        emit(AccountPageErrorState());
      } else {
        late String imgLink;
        if(accountInfoEntity.profilePicture == null){
          imgLink = 'string';
         } else {
          imgLink = accountInfoEntity.profilePicture!;
        }
        emit(AccountPageLoadedState(fullName: accountInfoEntity.fullName, email: accountInfoEntity.email, phoneNumber: accountInfoEntity.phoneNumber, imgLink: imgLink));
      }
    }
  }

  Future<void>logOut(BuildContext context) async{
    await setSharedStringUseCase.call('refreshToken', '');
    await setSharedStringUseCase.call('accessToken', '');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => IntroPage()));
  }

}
