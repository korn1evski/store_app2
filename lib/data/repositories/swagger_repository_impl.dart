
import 'package:store_app/data/remote/data_sources/swagger_remote_data_source.dart';
import 'package:store_app/domain/entities/category_entity.dart';
import 'package:store_app/domain/entities/products.entity.dart';
import 'package:store_app/domain/repositories/swagger_repository.dart';

class SwaggerRepositoryImpl extends SwaggerRepository {
  final SwaggerRemoteDataSource swaggerRemoteDataSource;
  SwaggerRepositoryImpl({required this.swaggerRemoteDataSource});
  @override
  Future<List<CategoryEntity>> getCategoriesData() async => swaggerRemoteDataSource.getCategoriesData();

  @override
  Future<ProductsEntity> getResultData(int currentPage) => swaggerRemoteDataSource.getResultData(currentPage);
}