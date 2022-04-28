
import 'package:store_app/domain/entities/category_entity.dart';

class ProductEntity {
  ProductEntity({
    required this.category,
    required this.name,
    required this.details,
    required this.size,
    required this.colour,
    required this.price,
    required this.id,
  });

  final CategoryEntity category;
  final String name;
  final String details;
  final String size;
  final String colour;
  final double price;
  final int id;

  static String properImage(String category){
    if (category.startsWith('Electronics')){
      return 'img/iphone.jpeg';
    } else if (category.startsWith('Men\'s Clothing')){
      return 'img/man.jpeg';
    } else if (category.startsWith('Hobby,')){
      return 'img/travel.jpeg';
    } else if (category.startsWith('Health')){
      return 'img/beauty.jpeg';
    } else if (category.startsWith('Home')){
      return 'img/home.jpeg';
    }  else if (category.startsWith('Women\'s')){
      return 'img/woman.jpeg';
    } else {
      return 'img/watch.jpeg';
    }
  }
}