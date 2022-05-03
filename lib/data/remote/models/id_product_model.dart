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
    required this.images,
    required this.reviews
  }) : super(category: CategoryModel.categoryModelToEntity(category), name: name, details: details, size: size, colour: colour, price: price, id: id, mainImage: mainImage, images: images, reviews: reviews);

  CategoryModel category;
  String name;
  String details;
  String size;
  String colour;
  double price;
  int id;
  String mainImage;
  List<ImageWrapper> images;
  List<Review> reviews;

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
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
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
    "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
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

class Review {
  Review({
    required this.id,
    required this.modifiedAt,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.rating,
    required this.message,
  });

  int id;
  DateTime modifiedAt;
  DateTime createdAt;
  String firstName;
  String lastName;
  String image;
  int rating;
  String message;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    modifiedAt: DateTime.parse(json["modified_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    firstName: json["first_name"],
    lastName: json["last_name"],
    image: json["image"],
    rating: json["rating"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "modified_at": modifiedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "first_name": firstName,
    "last_name": lastName,
    "image": image,
    "rating": rating,
    "message": message,
  };
}
