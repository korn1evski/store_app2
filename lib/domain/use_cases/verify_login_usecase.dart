
import '../repositories/users_repository.dart';

class VerifyLoginUseCase {
  final UsersRepository repository;
  VerifyLoginUseCase({required this.repository});

  Future<String> call(String refreshToken) async {
    return repository.verifyLogin(refreshToken);
  }
}