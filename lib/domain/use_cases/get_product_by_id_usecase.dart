
import '../entities/product_entity.dart';
import '../repositories/swagger_repository.dart';

class GetProductByIdUseCase {
  final SwaggerRepository repository;
  GetProductByIdUseCase({required this.repository});

  Future<ProductEntity> call(int id){
    return repository.getProductById(id);
  }
}