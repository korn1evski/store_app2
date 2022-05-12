
import 'package:store_app/domain/repositories/auth_repository.dart';

import '../local/data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  String? getSharedString(String key) => authRemoteDataSource.getSharedString(key);

  @override
  Future<void> setSharedString(String key, String value) async => authRemoteDataSource.setSharedString(key, value);

}