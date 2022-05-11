import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_app/domain/use_cases/register_user_usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.registerUserUseCase}) : super(RegisterInitial());

  final RegisterUserUseCase registerUserUseCase;

  Future<void> registerUser(String fullName, String email, String phoneNumber, String password) async{
    String message = await registerUserUseCase.call(fullName, email, phoneNumber, password);
    emit(RegistrationState(message: message));
  }

  void registerLoading(){
    emit(RegistrationLoadingState());
  }
}
