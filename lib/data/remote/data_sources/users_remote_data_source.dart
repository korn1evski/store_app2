
import '../../../domain/entities/account_info_entity.dart';

abstract class UsersRemoteDataSource{
  Future<int> registerUser(String fullName, String email, String phoneNumber, String password, String profilePicture);
  Future<List<String>> login(String email, String password);
  Future<String> verifyLogin(String refreshToken);
  Future<String> verifyLoginForAccountInfo(String refreshToken);
  Future<AccountInfoEntity?> accountInfo();
}