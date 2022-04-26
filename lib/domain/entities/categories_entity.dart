import 'package:equatable/equatable.dart';
import 'package:store_app/domain/entities/category_entity.dart';

class CategoriesEntity {
  final int count;
  final int totalPages;
  final int perPage;
  final int currentPage;
  final List<CategoryEntity> categories;
  CategoriesEntity({
    required this.count,
    required this.totalPages,
    required this.perPage,
    required this.currentPage,
    required this.categories,
  });

}