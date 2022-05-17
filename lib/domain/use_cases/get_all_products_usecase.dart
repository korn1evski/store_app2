
import 'package:store_app/domain/entities/product_entity.dart';
import 'package:store_app/domain/repositories/swagger_repository.dart';

class GetAllProductsUseCase {
  final SwaggerRepository repository;

  GetAllProductsUseCase({required this.repository});

  Future<List<ProductEntity>?> call(){
    return repository.getAllProducts();
  }


}