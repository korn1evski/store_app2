import 'package:store_app/domain/entities/cached_product_entity.dart';
import 'package:store_app/domain/entities/product_entity.dart';

class ProductViewModel {
  final int id;
  final String mainImage;
  final String name;
  final String details;
  final double price;

  ProductViewModel(
      {required this.id,
      required this.mainImage,
      required this.name,
      required this.details,
      required this.price});

  factory ProductViewModel.fromEntity(ProductEntity product) =>
      ProductViewModel(
          id: product.id,
          mainImage: product.mainImage,
          name: product.name,
          details: product.details,
          price: product.price);

  static List<ProductViewModel> fromEntityList(
      List<ProductEntity> productsEnt) {
    List<ProductViewModel> productsViews = [];
    for (var productEntity in productsEnt) {
      productsViews.add(ProductViewModel(
          id: productEntity.id,
          mainImage: productEntity.mainImage,
          name: productEntity.name,
          details: productEntity.details,
          price: productEntity.price));
    }
    return productsViews;
  }

  factory ProductViewModel.fromCachedProductEntity(
          CachedProductEntity cachedProductEntity) =>
      ProductViewModel(
          id: cachedProductEntity.id,
          mainImage: cachedProductEntity.mainImage,
          name: cachedProductEntity.name,
          details: cachedProductEntity.name,
          price: cachedProductEntity.price);
}
