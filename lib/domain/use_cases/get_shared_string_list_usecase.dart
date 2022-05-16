
import 'package:store_app/domain/repositories/auth_repository.dart';

class GetSharedStringListUseCase {
  final AuthRepository authRepository;

  GetSharedStringListUseCase({required this.authRepository});

  List<String>? call(String key){
    return authRepository.getSharedStringList(key);
  }
}
