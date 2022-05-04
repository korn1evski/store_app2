import 'package:equatable/equatable.dart';
import 'package:store_app/data/remote/models/id_product_model.dart';
import 'package:store_app/domain/entities/category_entity.dart';

class IdProductEntity extends Equatable{
  IdProductEntity({
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
  });

  final CategoryEntity category;
  final String name;
  final String details;
  final String size;
  final String colour;
  final double price;
  final int id;
  final String mainImage;
  final List<ImageWrapper> images;
  final List<Review> reviews;

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

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, reviews.length];
}