import 'package:store_app/data/local/data_bases/shop_db.dart';

class FavoriteEntity {

  const FavoriteEntity({required this.id, required this.mainImage, required this.name, required this.details, required this.price});

  final int id;
  final String mainImage;
  final String name;
  final String details;
  final double price;

  factory FavoriteEntity.fromFavoriteData({required FavoriteData favoriteData}){
    return FavoriteEntity(id: favoriteData.id, mainImage: favoriteData.mainImage, name: favoriteData.name, details: favoriteData.details, price: favoriteData.price);
  }

}