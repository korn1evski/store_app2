
import 'package:store_app/domain/repositories/auth_repository.dart';

class SetSharedStringListUseCase {
  SetSharedStringListUseCase({required this.authRepository});
  final AuthRepository authRepository;

  Future<void> call(String key, List<String> value){
    return authRepository.setSharedStringList(key, value);
  }
}