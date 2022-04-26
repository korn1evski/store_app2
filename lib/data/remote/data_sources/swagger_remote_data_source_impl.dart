import 'package:store_app/data/remote/data_sources/swagger_remote_data_source.dart';
import 'package:store_app/domain/entities/products.entity.dart';

import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/product_entity.dart';

import 'package:http/http.dart' as http;

import '../models/categories_model.dart';
import '../models/products_model.dart';

class SwaggerRemoteDataSourceImpl extends SwaggerRemoteDataSource {
  final String baseUrl = 'http://mobile-shop-api.hiring.devebs.net';

  @override
  Future<List<CategoryEntity>> getCategoriesData() async{
    const String apiURl = '/categories';
    http.Response response = await http.get(Uri.parse(baseUrl + apiURl));

    try{
      if (response.statusCode == 200){
        final CategoriesModel result = CategoriesModelFromJson(response.body);
        return result.categoriesModels;
      } else {
        return <CategoryEntity>[];
      }
    } catch(e){
      return <CategoryEntity>[];
    }
  }

  @override
  Future<ProductsEntity> getResultData(int currentPage) async{
    final String apiURl = "/products?page=" + currentPage.toString() + "&page_size=10";
    http.Response response = await http.get(Uri.parse(baseUrl + apiURl));

    try{
      if (response.statusCode == 200){
        final result = productsFromJson(response.body);
        return result;
      } else {
        List<ProductEntity> list = [];
        return ProductsEntity(count: 0, totalPages: 0, perPage: 0, currentPage: 0, products: list);
      }
    } catch(e){
      List<ProductEntity> list = [];
      return ProductsEntity(count: 0, totalPages: 0, perPage: 0, currentPage: 0, products: list);
    }
  }

}