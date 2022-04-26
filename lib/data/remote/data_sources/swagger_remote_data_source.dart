import 'package:store_app/domain/entities/products.entity.dart';

import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/product_entity.dart';

abstract class SwaggerRemoteDataSource{
  Future<ProductsEntity> getResultData(int currentPage);
  Future<List<CategoryEntity>> getCategoriesData();
}