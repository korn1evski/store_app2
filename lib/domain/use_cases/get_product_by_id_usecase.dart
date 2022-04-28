
import 'package:store_app/domain/entities/id_product_entity.dart';

import '../entities/product_entity.dart';
import '../repositories/swagger_repository.dart';

class GetProductByIdUseCase {
  final SwaggerRepository repository;
  GetProductByIdUseCase({required this.repository});

  Future<IdProductEntity> call(int id){
    return repository.getProductById(id);
  }
}