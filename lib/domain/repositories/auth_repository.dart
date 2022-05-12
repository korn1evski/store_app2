
abstract class AuthRepository {
  String? getSharedString(String key);
  Future<void> setSharedString(String key, String value);
}