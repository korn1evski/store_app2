
import 'package:store_app/domain/entities/cached_product_entity.dart';

abstract class CachedProductsDataSource {
  Future<List<CachedProductEntity>> getCachedProducts();
  Future<int> insertCachedProduct(CachedProductEntity cachedProductEntity);
}