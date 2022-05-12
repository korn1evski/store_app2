
import 'package:store_app/domain/repositories/auth_repository.dart';

class GetSharedStringUseCase {
  final AuthRepository repository;
  GetSharedStringUseCase({required this.repository});

  String? call(String key){
    return repository.getSharedString(key);
  }
}