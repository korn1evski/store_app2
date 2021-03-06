
import 'dart:io';

import 'package:store_app/domain/entities/category_entity.dart';
import 'package:store_app/domain/entities/id_product_entity.dart';
import 'package:store_app/domain/entities/product_entity.dart';

import '../entities/products.entity.dart';

abstract class SwaggerRepository {
  Future<ProductsEntity?> getResultData(int currentPage);
  Future<List<CategoryEntity>?> getCategoriesData();
  Future<IdProductEntity?> getProductById(int id);
  Future<List<ProductEntity>?> getAllProducts();
  Future<void> sendReview({required int id, required String firstName, required String lastName, required int rating, required String message, required String img});
  Future<String> uploadImage(File image);
}