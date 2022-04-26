import 'package:store_app/domain/entities/category_entity.dart';
import 'package:store_app/domain/repositories/swagger_repository.dart';

class GetCategoriesDataUseCase {

  final SwaggerRepository repository;

  GetCategoriesDataUseCase({required this.repository});

  Future<List<CategoryEntity>> call(){
    return repository.getCategoriesData();
  }
}