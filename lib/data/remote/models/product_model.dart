import 'dart:convert';

import 'package:store_app/data/remote/models/category_model.dart';
import 'package:store_app/domain/entities/product_entity.dart';

ProductModel productFromJson(String str) => ProductModel.fromJson(json.decode(str));

class ProductModel extends ProductEntity{
  ProductModel({
    required this.category,
    required this.name,
    required this.details,
    required this.size,
    required this.colour,
    required this.price,
    required this.soldCount,
    required this.id,
  }) : super(category: CategoryModel.categoryModelToEntity(category), name: name, details: details, size: size, colour: colour, price: price, soldCount: soldCount, id: id);

  CategoryModel category;
  String name;
  String details;
  String size;
  String colour;
  double price;
  int soldCount;
  int id;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    category: CategoryModel.fromJson(json["category"]),
    name: json["name"],
    details: json["details"],
    size: json["size"],
    colour: json["colour"],
    price: json["price"],
    soldCount: json["sold_count"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "category": category.toJson(),
    "name": name,
    "details": details,
    "size": size,
    "colour": colour,
    "price": price,
    "sold_count": soldCount,
    "id": id,
  };

  static List<ProductEntity> categoryModelsToEntity(List<ProductModel> listModels){
    List<ProductEntity> listEntities = [];
    for (var model in listModels){
      var entity = ProductEntity(category: model.category, name: model.name, details: model.details, size: model.size, colour: model.colour, price: model.price, soldCount: model.soldCount, id: model.id);
      listEntities.add(entity);
    }

    return listEntities;
  }
}
