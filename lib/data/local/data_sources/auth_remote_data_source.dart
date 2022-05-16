
abstract class AuthRemoteDataSource {
  String? getSharedString(String key);
  Future<void> setSharedString(String key, String value);
  List<String>? getSharedStringList(String key);
  Future<void> setSharedStringList(String key, List<String> value);
}