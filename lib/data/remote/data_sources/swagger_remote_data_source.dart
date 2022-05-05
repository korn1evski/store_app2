import 'dart:io';

import 'package:store_app/domain/entities/id_product_entity.dart';
import 'package:store_app/domain/entities/products.entity.dart';

import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/product_entity.dart';

abstract class SwaggerRemoteDataSource{
  Future<ProductsEntity> getResultData(int currentPage);
  Future<List<CategoryEntity>> getCategoriesData();
  Future<IdProductEntity> getProductById(int id);
  Future<List<ProductEntity>> getAllProducts();
  Future<void> sendReview({required int id, required String firstName, required String lastName, required int rating, required String message, required String img});
  Future<String> uploadImage(File image);
}