
import 'package:store_app/domain/entities/cached_product_entity.dart';
import 'package:store_app/domain/repositories/cached_products_repository.dart';

class GetCachedProductsUseCase {
  final CachedProductsRepository cachedProductsRepository;
  GetCachedProductsUseCase({required this.cachedProductsRepository});

  Future<List<CachedProductEntity>> call(){
    return cachedProductsRepository.getCachedProducts();
  }
}