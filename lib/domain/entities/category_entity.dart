import 'package:equatable/equatable.dart';
import 'package:store_app/data/local/data_bases/shop_db.dart';

class CategoryEntity extends Equatable {
  CategoryEntity({
    required this.name,
    required this.icon,
  });

  final String name;
  final String icon;

  @override
  // TODO: implement props
  List<Object?> get props => [name, icon];

  factory CategoryEntity.fromCachedCategoryData(CachedCategoryData cachedCategoryData){
    return CategoryEntity(name: cachedCategoryData.name, icon: cachedCategoryData.icon);
  }
}
