import 'dart:convert';

import 'package:store_app/data/remote/models/category_model.dart';
import 'package:store_app/domain/entities/id_product_entity.dart';
import 'package:store_app/domain/entities/product_entity.dart';

IdProductModel  idProductFromJson(String str) => IdProductModel.fromJson(json.decode(str));

class IdProductModel extends IdProductEntity{
  IdProductModel ({
    required this.category,
    required this.name,
    required this.details,
    required this.size,
    required this.colour,
    required this.price,
    required this.id,
    required this.mainImage,
    required this.images
  }) : super(category: CategoryModel.categoryModelToEntity(category), name: name, details: details, size: size, colour: colour, price: price, id: id, mainImage: mainImage, images: images);

  CategoryModel category;
  String name;
  String details;
  String size;
  String colour;
  double price;
  int id;
  String mainImage;
  List<ImageWrapper> images;

  factory IdProductModel.fromJson(Map<String, dynamic> json) => IdProductModel(
    category: CategoryModel.fromJson(json["category"]),
    name: json["name"],
    details: json["details"],
    size: json["size"],
    colour: json["colour"],
    price: json["price"],
    id: json["id"],
    mainImage: json["main_image"],
    images: List<ImageWrapper>.from(json["images"].map((x) => ImageWrapper.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category.toJson(),
    "name": name,
    "details": details,
    "size": size,
    "colour": colour,
    "price": price,
    "id": id,
    "main_image" : mainImage,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
  };

}

class ImageWrapper {
  ImageWrapper({
    required this.image,
  });

  String image;

  factory ImageWrapper.fromJson(Map<String, dynamic> json) => ImageWrapper(
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
  };
}