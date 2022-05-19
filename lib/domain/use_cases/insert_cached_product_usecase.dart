
import 'package:store_app/domain/entities/cached_product_entity.dart';
import 'package:store_app/domain/repositories/cached_products_repository.dart';

class InsertCachedProductUseCase {
  final CachedProductsRepository cachedProductsRepository;

  InsertCachedProductUseCase({required this.cachedProductsRepository});

  Future<int> call(CachedProductEntity cachedProductEntity){
    return cachedProductsRepository.insertCachedProduct(cachedProductEntity);
  }
}