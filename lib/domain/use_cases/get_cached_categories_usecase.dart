
import 'package:store_app/domain/entities/category_entity.dart';
import 'package:store_app/domain/repositories/cached_categories_repository.dart';

class GetCachedCategoriesUseCase {
  final CachedCategoriesRepository repository;
  GetCachedCategoriesUseCase({required this.repository});

  Future<List<CategoryEntity>> call() async {
    return repository.getCachedCategories();
  }
}