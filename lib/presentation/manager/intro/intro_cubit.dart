import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/domain/use_cases/verify_login_usecase.dart';
import 'package:store_app/injection_container.dart' as di;
part 'intro_state.dart';

class IntroCubit extends Cubit<IntroState> {
  IntroCubit({required this.verifyLoginUseCase}) : super(IntroInitial());

  final VerifyLoginUseCase verifyLoginUseCase;
  final prefs = di.sl<SharedPreferences>();

  Future<void> verifyLogin(String refreshToken) async{
    emit(IntroLoadingState());
    String result = await verifyLoginUseCase.call(refreshToken);
    if(result == ''){
      emit(IntroErrorLoadedState());
    } else {
      await prefs.setString('accessToken', result);
      emit(IntroLoadedState());
    }
  }
}
