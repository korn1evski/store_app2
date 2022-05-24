import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:store_app/data/remote/data_sources/swagger_remote_data_source.dart';
import 'package:store_app/data/remote/models/id_product_model.dart';
import 'package:store_app/domain/entities/id_product_entity.dart';
import 'package:store_app/domain/entities/products.entity.dart';

import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/product_entity.dart';
import 'package:http/http.dart' as http;
import '../models/categories_model.dart';
import '../models/imgbb_model.dart';
import '../models/products_model.dart';

class SwaggerRemoteDataSourceImpl extends SwaggerRemoteDataSource {
  final String baseUrl = 'http://mobile-shop-api.hiring.devebs.net';
  final Dio dio;

  SwaggerRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CategoryEntity>?> getCategoriesData() async {
    const String apiURl = '/categories';
    http.Response response = await http.get(Uri.parse(baseUrl + apiURl));

    try {
      if (response.statusCode == 200) {
        final CategoriesModel result = CategoriesModelFromJson(response.body);
        return result.categoriesModels;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ProductsEntity?> getResultData(int currentPage) async {
    final String apiURl =
        "/products?page=" + currentPage.toString() + "&page_size=10";
    http.Response response = await http.get(Uri.parse(baseUrl + apiURl));

    try {
      if (response.statusCode == 200) {
        final result = productsFromJson(response.body);
        return result;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<IdProductEntity?> getProductById(int id) async {
    String apiUrl = '/products/$id';
   final response = await dio.get(baseUrl + apiUrl);

    try {
      if (response.statusCode == 200) {
        final idProductEntity = IdProductModel.fromJson(response.data);
        return idProductEntity;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<ProductEntity>?> getAllProducts() async {
    const String apiUrl = '/products?page_size=100000';
    http.Response response = await http.get(Uri.parse(baseUrl + apiUrl));

    try {
      if (response.statusCode == 200) {
        final ProductsEntity productsEntity = productsFromJson(response.body);
        return productsEntity.products;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> sendReview(
      {required int id,
      required String firstName,
      required String lastName,
      required int rating,
      required String message,
      required String img
      }) async {
    String apiUrl = '/products/$id/add-review';

    try {
      final response = await http.post(Uri.parse(baseUrl + apiUrl), body: {
        "first_name": firstName,
        "last_name": lastName,
        "image": img,
        "rating": rating.toString(),
        "message": message
      });

      print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<String> uploadImage(File image) async{
    Dio dio = Dio();
    try {
      // ByteData bytes = await rootBundle.load(image.path);
      final bytes = await image.readAsBytes();
      var buffer = bytes.buffer;
      var m = base64.encode(Uint8List.view(buffer));

      FormData formData = FormData.fromMap(
          {"key": '69ac5ee9c3494e21806183fbb5f9df2a', "image": m});

      Response response = await dio.post(
        "https://api.imgbb.com/1/upload",
        data: formData,
      );

      if(response.statusCode != 400){
        return ImgbbResponseModel.fromJson(response.data).data.displayUrl;
      } else {
        return 'string';
      }
    } catch (e) {
      return 'string';
    }
  }
}
