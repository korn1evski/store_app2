
import 'package:drift/drift.dart';
import 'package:store_app/data/local/data_bases/shop_db.dart';
import 'package:store_app/data/local/data_sources/cached_products_data_source.dart';
import 'package:store_app/domain/entities/cached_product_entity.dart';

import '../models/cached_products_model.dart';

part 'cached_products_dao.g.dart';

@DriftAccessor(tables: [CachedProducts])
class CachedProductsDao extends DatabaseAccessor<ShopDb> with _$CachedProductsDaoMixin, CachedProductsDataSource{
  CachedProductsDao(ShopDb db) : super(db);

  @override
  Future<List<CachedProductEntity>> getCachedProducts() async{
    try {
      final cachedProductsDataList = await select(cachedProducts).get();
      final List<CachedProductEntity> cachedEntityList = [];
      for (final cachedData in cachedProductsDataList) {
        cachedEntityList.add(CachedProductEntity.fromCachedProductData(
            cachedProduct: cachedData));
      }
      return cachedEntityList;
    } catch(e){
      return [];
    }
  }

  @override
  Future<int> insertCachedProduct(CachedProductEntity cachedProductEntity) async {
    try {
      final cachedProductsCompanion = CachedProductsCompanion(
          id: Value(cachedProductEntity.id),
          mainImage: Value(cachedProductEntity.mainImage),
          name: Value(cachedProductEntity.name),
          details: Value(cachedProductEntity.details),
          price: Value(cachedProductEntity.price)
      );

      return await into(cachedProducts).insert(cachedProductsCompanion);
    } catch (e) {
      return -1;
    }
  }
}