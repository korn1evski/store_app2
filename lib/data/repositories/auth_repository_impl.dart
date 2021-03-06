
import 'package:store_app/domain/repositories/auth_repository.dart';

import '../local/data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  String? getSharedString(String key) => authRemoteDataSource.getSharedString(key);

  @override
  Future<void> setSharedString(String key, String value) async => authRemoteDataSource.setSharedString(key, value);

  @override
  List<String>? getSharedStringList(String key) => authRemoteDataSource.getSharedStringList(key);

  @override
  Future<void> setSharedStringList(String key, List<String> value) async => authRemoteDataSource.setSharedStringList(key, value);

}