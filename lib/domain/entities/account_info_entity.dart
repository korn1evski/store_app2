class AccountInfoEntity {
  AccountInfoEntity(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.phoneNumber});

  final int id;
  final String fullName;
  final String email;
  final String phoneNumber;
}
