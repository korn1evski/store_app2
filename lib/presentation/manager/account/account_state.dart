part of 'account_cubit.dart';

abstract class AccountState extends Equatable {
  const AccountState();
}

class AccountInitial extends AccountState {
  @override
  List<Object> get props => [];
}

class AccountPageLoadingState extends AccountState {
  @override
  List<Object> get props => [];
}

class AccountPageErrorState extends AccountState {
  @override
  List<Object> get props => [];
}

class AccountPageLoadedState extends AccountState {
  AccountPageLoadedState({required this.fullName, required this.email, required this.phoneNumber, required this.imgLink});
  final String fullName;
  final String email;
  final String phoneNumber;
  final String imgLink;
  @override
  List<Object> get props => [fullName, email, phoneNumber, imgLink];
}

