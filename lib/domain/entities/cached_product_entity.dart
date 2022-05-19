
import 'package:store_app/data/local/data_bases/shop_db.dart';
import 'package:store_app/domain/entities/product_entity.dart';
import 'package:store_app/presentation/manager/view_models/product_viewmodel.dart';

class CachedProductEntity {
  const CachedProductEntity({required this.id, required this.mainImage, required this.name, required this.details, required this.price});

  final int id;
  final String mainImage;
  final String name;
  final String details;
  final double price;

  factory CachedProductEntity.fromCachedProductData({required CachedProduct cachedProduct}){
    return CachedProductEntity(id: cachedProduct.id, mainImage: cachedProduct.mainImage, name: cachedProduct.name, details: cachedProduct.details, price: cachedProduct.price);
  }

  factory CachedProductEntity.fromProductViewModel({required ProductViewModel productViewModel}){
    return CachedProductEntity(id: productViewModel.id, mainImage: productViewModel.mainImage, name: productViewModel.name, details: productViewModel.details, price: productViewModel.price);
  }

  factory CachedProductEntity.fromProductEntity({required ProductEntity productEntity}){
    return CachedProductEntity(id: productEntity.id, mainImage: productEntity.mainImage, name: productEntity.name, details: productEntity.details, price: productEntity.price);
  }
}