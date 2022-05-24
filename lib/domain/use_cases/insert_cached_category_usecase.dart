
import 'package:store_app/domain/entities/category_entity.dart';

import '../repositories/cached_categories_repository.dart';

class InsertCachedCategoryUseCase {
  final CachedCategoriesRepository repository;
  InsertCachedCategoryUseCase({required this.repository});

  Future<void> call(CategoryEntity categoryEntity) async {
    return repository.insertCachedCategory(categoryEntity);
  }
}