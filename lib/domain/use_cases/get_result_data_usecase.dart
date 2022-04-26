import 'package:store_app/domain/repositories/swagger_repository.dart';

import '../entities/products.entity.dart';

class GetResultDataUseCase {
  final SwaggerRepository repository;
  GetResultDataUseCase({required this.repository});

  Future<ProductsEntity> call(int currentPage) async {
    return repository.getResultData(currentPage);
  }
}