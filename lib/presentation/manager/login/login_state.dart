part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFinishedState extends LoginState {
  final message;
  LoginFinishedState({required this.message});
  @override
  List<Object> get props => [message];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}
