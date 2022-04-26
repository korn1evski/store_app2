import 'dart:convert';

import 'package:store_app/domain/entities/categories_entity.dart';

import 'category_model.dart';

CategoriesModel CategoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String CategoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel extends CategoriesEntity{
  CategoriesModel({
    required this.count,
    required this.totalPages,
    required this.perPage,
    required this.currentPage,
    required this.categoriesModels,
  }) : super(count: count, totalPages: totalPages, perPage: perPage, currentPage: currentPage, categories: CategoryModel.categoryModelsToEntity(categoriesModels));

  final int count;
  final int totalPages;
  final int perPage;
  final int currentPage;
  final List<CategoryModel> categoriesModels;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    count: json["count"],
    totalPages: json["total_pages"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    categoriesModels: List<CategoryModel>.from(json["results"].map((x) => CategoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "total_pages": totalPages,
    "per_page": perPage,
    "current_page": currentPage,
    "results": List<dynamic>.from(categoriesModels.map((x) => x.toJson())),
  };
}