import '../entities/category_entity.dart';

abstract class CachedCategoriesRepository {
  Future<void> insertCachedCategory(CategoryEntity categoryEntity);
  Future<List<CategoryEntity>> getCachedCategories();
}