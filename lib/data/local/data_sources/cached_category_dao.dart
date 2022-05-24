import 'package:drift/drift.dart';
import 'package:store_app/data/local/data_bases/shop_db.dart';
import 'package:store_app/data/local/data_sources/cached_categories_data_source.dart';
import 'package:store_app/data/local/models/cached_category_model.dart';
import 'package:store_app/data/local/models/favorite_model.dart';
import 'package:store_app/domain/entities/category_entity.dart';

import '../../../domain/entities/favorite_entity.dart';
import 'favorites_data_source.dart';

part 'cached_category_dao.g.dart';

@DriftAccessor(tables: [CachedCategory])
class CachedCategoryDao extends DatabaseAccessor<ShopDb>
    with _$CachedCategoryDaoMixin, CachedCategoriesDataSource {
  CachedCategoryDao(ShopDb db) : super(db);

  @override
  Future<void> insertCachedCategory(CategoryEntity categoryEntity) async {
    try {
      final cachedCategoryCompanion = CachedCategoryCompanion(
          name: Value(categoryEntity.name), icon: Value(categoryEntity.icon));

      await into(cachedCategory).insert(cachedCategoryCompanion);
    } catch (e) {
      return;
    }
  }

  @override
  Future<List<CategoryEntity>> getCachedCategories() async {
    try {
      final cachedCategoriesList = await select(cachedCategory).get();
      final List<CategoryEntity> cachedEntityList = [];
      for (final cachedData in cachedCategoriesList) {
        cachedEntityList.add(CategoryEntity.fromCachedCategoryData(cachedData));
      }
      return cachedEntityList;
    } catch (e) {
      return [];
    }
  }
}
