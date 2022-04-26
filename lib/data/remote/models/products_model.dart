// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

import 'package:store_app/data/remote/models/product_model.dart';
import 'package:store_app/domain/entities/products.entity.dart';

ProductsModel productsFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel extends ProductsEntity{
  ProductsModel({
    required this.count,
    required this.totalPages,
    required this.perPage,
    required this.currentPage,
    required this.productsModels,
  }) : super(count: count, totalPages: totalPages, perPage: perPage, currentPage: currentPage, products: ProductModel.categoryModelsToEntity(productsModels));

  int count;
  int totalPages;
  int perPage;
  int currentPage;
  List<ProductModel> productsModels;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    count: json["count"],
    totalPages: json["total_pages"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    productsModels: List<ProductModel>.from(json["results"].map((x) => ProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "total_pages": totalPages,
    "per_page": perPage,
    "current_page": currentPage,
    "results": List<dynamic>.from(productsModels.map((x) => x.toJson())),
  };
}
