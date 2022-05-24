

import '../../../domain/entities/category_entity.dart';

abstract class CachedCategoriesDataSource {
  Future<void> insertCachedCategory(CategoryEntity categoryEntity);
  Future<List<CategoryEntity>> getCachedCategories();
}