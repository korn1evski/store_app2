import 'dart:convert';

import 'package:store_app/domain/entities/account_info_entity.dart';

AccountInfoModel accountInfoModelFromJson(String str) => AccountInfoModel.fromJson(json.decode(str));

String accountInfoModelToJson(AccountInfoModel data) => json.encode(data.toJson());

class AccountInfoModel extends AccountInfoEntity{
  AccountInfoModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.profilePicture
  }) : super(id: id, fullName: fullName, email: email, phoneNumber: phoneNumber, profilePicture: profilePicture);

  final int id;
  final String fullName;
  final String email;
  final String phoneNumber;
  String? profilePicture;

  factory AccountInfoModel.fromJson(Map<String, dynamic> json) => AccountInfoModel(
    id: json["id"],
    fullName: json["full_name"],
    email: json['email'],
    phoneNumber: json['phone_number'],
    profilePicture: json['profile_picture']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "email" : email,
    "phoneNumber" : phoneNumber,
    "profile_picture" : profilePicture
  };
}