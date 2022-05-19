
import 'package:store_app/data/local/data_sources/cached_products_data_source.dart';
import 'package:store_app/domain/entities/cached_product_entity.dart';
import 'package:store_app/domain/repositories/cached_products_repository.dart';

class CachedProductsRepositoryImpl extends CachedProductsRepository{
  final CachedProductsDataSource cachedProductsDataSource;
  CachedProductsRepositoryImpl({required this.cachedProductsDataSource});

  @override
  Future<List<CachedProductEntity>> getCachedProducts() async => cachedProductsDataSource.getCachedProducts();

  @override
  Future<int> insertCachedProduct(CachedProductEntity cachedProductEntity) async => cachedProductsDataSource.insertCachedProduct(cachedProductEntity);
}