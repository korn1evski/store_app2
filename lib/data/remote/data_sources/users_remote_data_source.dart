
import '../../../domain/entities/account_info_entity.dart';

abstract class UsersRemoteDataSource{
  Future<String> registerUser(String fullName, String email, String phoneNumber, String password);
  Future<List<String>> login(String email, String password);
  Future<String> verifyLogin(String refreshToken);
  Future<AccountInfoEntity> accountInfo(String accessToken);
}