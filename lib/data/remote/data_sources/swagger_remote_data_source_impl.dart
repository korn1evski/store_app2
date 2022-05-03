import 'package:store_app/data/remote/data_sources/swagger_remote_data_source.dart';
import 'package:store_app/data/remote/models/id_product_model.dart';
import 'package:store_app/domain/entities/id_product_entity.dart';
import 'package:store_app/domain/entities/products.entity.dart';

import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/product_entity.dart';
import 'package:http/http.dart' as http;
import '../models/categories_model.dart';
import '../models/products_model.dart';

class SwaggerRemoteDataSourceImpl extends SwaggerRemoteDataSource {
  final String baseUrl = 'http://mobile-shop-api.hiring.devebs.net';

  @override
  Future<List<CategoryEntity>> getCategoriesData() async {
    const String apiURl = '/categories';
    http.Response response = await http.get(Uri.parse(baseUrl + apiURl));

    try {
      if (response.statusCode == 200) {
        final CategoriesModel result = CategoriesModelFromJson(response.body);
        return result.categoriesModels;
      } else {
        return <CategoryEntity>[];
      }
    } catch (e) {
      return <CategoryEntity>[];
    }
  }

  @override
  Future<ProductsEntity> getResultData(int currentPage) async {
    final String apiURl =
        "/products?page=" + currentPage.toString() + "&page_size=10";
    http.Response response = await http.get(Uri.parse(baseUrl + apiURl));

    try {
      if (response.statusCode == 200) {
        final result = productsFromJson(response.body);
        return result;
      } else {
        List<ProductEntity> list = [];
        return ProductsEntity(
            count: 0,
            totalPages: 0,
            perPage: 0,
            currentPage: 0,
            products: list);
      }
    } catch (e) {
      List<ProductEntity> list = [];
      return ProductsEntity(
          count: 0, totalPages: 0, perPage: 0, currentPage: 0, products: list);
    }
  }

  @override
  Future<IdProductEntity> getProductById(int id) async {
    String apiUrl = '/products/$id';
    http.Response response = await http.get(Uri.parse(baseUrl + apiUrl));

    try {
      if (response.statusCode == 200) {
        final idProductEntity = idProductFromJson(response.body);
        return idProductEntity;
      } else {
        return IdProductEntity(
            category: CategoryEntity(name: '', icon: ''),
            name: '',
            details: '',
            size: '',
            colour: '',
            price: 0,
            id: -1,
            mainImage: '',
            images: <ImageWrapper>[],
            reviews: <Review>[]
        );
      }
    } catch (e) {
      return IdProductEntity(
          category: CategoryEntity(name: '', icon: ''),
          name: '',
          details: '',
          size: '',
          colour: '',
          price: 0,
          id: -1,
          mainImage: '',
          images: <ImageWrapper>[],
          reviews: <Review>[]
      );
    }
  }

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    const String apiUrl = '/products?page_size=100000';
    http.Response response = await http.get(Uri.parse(baseUrl + apiUrl));

    try {
      if (response.statusCode == 200) {
        final ProductsEntity productsEntity = productsFromJson(response.body);
        return productsEntity.products;
      } else {
        return <ProductEntity>[];
      }
    } catch (e) {
      return <ProductEntity>[];
    }
  }
}
