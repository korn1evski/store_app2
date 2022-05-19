part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegistrationLoadingState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegistrationState extends RegisterState {
  String message;
  RegistrationState({required this.message});
  @override
  List<Object> get props => [message];
}

class ProvideRegisterImageState extends RegisterState {
  const ProvideRegisterImageState({required this.link, required this.image});
  final String link;
  final File image;
  @override
  List<Object> get props => [link, image];
}

