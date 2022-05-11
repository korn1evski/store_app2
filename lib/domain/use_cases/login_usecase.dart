
import 'package:store_app/domain/repositories/users_repository.dart';

class LoginUseCase {
  final UsersRepository repository;
  LoginUseCase({required this.repository});

  Future<List<String>> call(String email, String password) async {
    return repository.login(email, password);
  }
}