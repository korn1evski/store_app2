import 'dart:convert';

import 'package:store_app/domain/entities/account_info_entity.dart';

AccountInfoModel accountInfoModelFromJson(String str) => AccountInfoModel.fromJson(json.decode(str));

String accountInfoModelToJson(AccountInfoModel data) => json.encode(data.toJson());

class AccountInfoModel extends AccountInfoEntity{
  AccountInfoModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber
  }) : super(id: id, fullName: fullName, email: email, phoneNumber: phoneNumber);

  final int id;
  final String fullName;
  final String email;
  final String phoneNumber;

  factory AccountInfoModel.fromJson(Map<String, dynamic> json) => AccountInfoModel(
    id: json["id"],
    fullName: json["full_name"],
    email: json['email'],
    phoneNumber: json['phone_number']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "email" : email,
    "phoneNumber" : phoneNumber
  };
}