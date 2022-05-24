import 'package:store_app/domain/repositories/users_repository.dart';

import '../../domain/entities/account_info_entity.dart';
import '../remote/data_sources/users_remote_data_source.dart';

class UsersRepositoryImpl extends UsersRepository {
  final UsersRemoteDataSource usersRemoteDataSource;

  UsersRepositoryImpl({required this.usersRemoteDataSource});

  @override
  Future<int> registerUser(String fullName, String email, String phoneNumber,
          String password, String profilePicture) async =>
      usersRemoteDataSource.registerUser(
          fullName, email, phoneNumber, password, profilePicture);

  @override
  Future<List<String>> login(String email, String password) async => usersRemoteDataSource.login(email, password);

  @override
  Future<String> verifyLogin(String refreshToken) async => usersRemoteDataSource.verifyLogin(refreshToken);

  @override
  Future<AccountInfoEntity?> accountInfo() async => usersRemoteDataSource.accountInfo();

  @override
  Future<String> verifyLoginForAccountInfo(String refreshToken) async => usersRemoteDataSource.verifyLoginForAccountInfo(refreshToken);
}
