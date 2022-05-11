import 'dart:convert';

RefreshResponseModel refreshResponseModelFromJson(String str) => RefreshResponseModel.fromJson(json.decode(str));

String refreshResponseModelToJson(RefreshResponseModel data) => json.encode(data.toJson());

class RefreshResponseModel {
  RefreshResponseModel({
    required this.access,
  });

  String access;

  factory RefreshResponseModel.fromJson(Map<String, dynamic> json) => RefreshResponseModel(
    access: json["access"],
  );

  Map<String, dynamic> toJson() => {
    "access": access,
  };
}
