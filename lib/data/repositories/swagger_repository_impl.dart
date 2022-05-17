import 'dart:io';

import 'package:store_app/data/remote/data_sources/swagger_remote_data_source.dart';
import 'package:store_app/domain/entities/category_entity.dart';
import 'package:store_app/domain/entities/id_product_entity.dart';
import 'package:store_app/domain/entities/product_entity.dart';
import 'package:store_app/domain/entities/products.entity.dart';
import 'package:store_app/domain/repositories/swagger_repository.dart';

class SwaggerRepositoryImpl extends SwaggerRepository {
  final SwaggerRemoteDataSource swaggerRemoteDataSource;

  SwaggerRepositoryImpl({required this.swaggerRemoteDataSource});

  @override
  Future<List<CategoryEntity>?> getCategoriesData() async =>
      swaggerRemoteDataSource.getCategoriesData();

  @override
  Future<ProductsEntity?> getResultData(int currentPage) async =>
      swaggerRemoteDataSource.getResultData(currentPage);

  @override
  Future<IdProductEntity?> getProductById(int id) async =>
      swaggerRemoteDataSource.getProductById(id);

  @override
  Future<List<ProductEntity>?> getAllProducts() async =>
      swaggerRemoteDataSource.getAllProducts();

  @override
  Future<void> sendReview(
          {required int id,
          required String firstName,
          required String lastName,
          required int rating,
          required String message,
          required String img}) async =>
      swaggerRemoteDataSource.sendReview(
          id: id,
          firstName: firstName,
          lastName: lastName,
          rating: rating,
          message: message,
        img: img
      );

  @override
  Future<String> uploadImage(File image) async {
   return swaggerRemoteDataSource.uploadImage(image);
  }
}
