
import 'package:store_app/domain/entities/cached_product_entity.dart';

abstract class CachedProductsRepository {
  Future<List<CachedProductEntity>> getCachedProducts();

  Future<int> insertCachedProduct(CachedProductEntity cachedProductEntity);
}