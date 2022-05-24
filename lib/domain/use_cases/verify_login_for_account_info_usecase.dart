
import '../repositories/users_repository.dart';

class VerifyLoginForAccountInfoUseCase {
  final UsersRepository repository;
  VerifyLoginForAccountInfoUseCase({required this.repository});

  Future<String> call(String refreshToken) async {
    return repository.verifyLoginForAccountInfo(refreshToken);
  }
}