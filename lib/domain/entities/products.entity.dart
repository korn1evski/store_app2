
import 'package:store_app/domain/entities/product_entity.dart';

class ProductsEntity {

  ProductsEntity({
  required this.count,
  required this.totalPages,
  required this.perPage,
  required this.currentPage,
  required this.products,
  });

  int count;
  int totalPages;
  int perPage;
  int currentPage;
  List<ProductEntity> products;
}