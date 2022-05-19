
import 'package:store_app/domain/repositories/users_repository.dart';

class RegisterUserUseCase {
  final UsersRepository repository;
  RegisterUserUseCase({required this.repository});

  Future<int> call(String fullName, String email, String phoneNumber, String password, String profilePicture) async {
    return repository.registerUser(fullName, email, phoneNumber, password, profilePicture);
  }
}