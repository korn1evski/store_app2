
abstract class AuthRemoteDataSource {
  String? getSharedString(String key);
  Future<void> setSharedString(String key, String value);
}