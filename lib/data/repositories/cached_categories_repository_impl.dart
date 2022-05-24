
import 'package:store_app/data/local/data_sources/cached_categories_data_source.dart';
import 'package:store_app/domain/entities/category_entity.dart';
import 'package:store_app/domain/repositories/cached_categories_repository.dart';

class CachedCategoriesRepositoryImpl extends CachedCategoriesRepository {
  final CachedCategoriesDataSource cachedCategoriesDataSource;

  CachedCategoriesRepositoryImpl({required this.cachedCategoriesDataSource});

  @override
  Future<List<CategoryEntity>> getCachedCategories() async => cachedCategoriesDataSource.getCachedCategories();

  @override
  Future<void> insertCachedCategory(CategoryEntity categoryEntity) => cachedCategoriesDataSource.insertCachedCategory(categoryEntity);

}