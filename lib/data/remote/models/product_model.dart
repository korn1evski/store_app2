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
    required this.id,
    required this.mainImage
  }) : super(category: CategoryModel.categoryModelToEntity(category), name: name, details: details, size: size, colour: colour, price: price, id: id, mainImage: mainImage);

  CategoryModel category;
  String name;
  String details;
  String size;
  String colour;
  double price;
  int id;
  String mainImage;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    category: CategoryModel.fromJson(json["category"]),
    name: json["name"],
    details: json["details"],
    size: json["size"],
    colour: json["colour"],
    price: json["price"],
    id: json["id"],
    mainImage: json["main_image"],
  );

  Map<String, dynamic> toJson() => {
    "category": category.toJson(),
    "name": name,
    "details": details,
    "size": size,
    "colour": colour,
    "price": price,
    "id": id,
    "main_image" : mainImage
  };

  static List<ProductEntity> categoryModelsToEntity(List<ProductModel> listModels){
    List<ProductEntity> listEntities = [];
    for (var model in listModels){
      var entity = ProductEntity(category: model.category, name: model.name, details: model.details, size: model.size, colour: model.colour, price: model.price, id: model.id, mainImage: model.mainImage);
      listEntities.add(entity);
    }

    return listEntities;
  }
}
