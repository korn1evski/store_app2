
import 'package:store_app/domain/repositories/auth_repository.dart';

class SetSharedStringUseCase {
  final AuthRepository repository;

  SetSharedStringUseCase({required this.repository});

  Future<void> call(String key, String value) async{
    return repository.setSharedString(key, value);
  }
}