
import 'package:store_app/domain/entities/category_entity.dart';
import 'package:store_app/domain/entities/product_entity.dart';

import '../entities/products.entity.dart';

abstract class SwaggerRepository {
  Future<ProductsEntity> getResultData(int currentPage);
  Future<List<CategoryEntity>> getCategoriesData();
}