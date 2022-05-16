
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_remote_data_source.dart';
import 'package:store_app/injection_container.dart' as di;

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {

  final prefs = di.sl<SharedPreferences>();

  @override
  String? getSharedString(String key) {
    return prefs.getString(key);
  }

  @override
  Future<void> setSharedString(String key, String value) async{
    prefs.setString(key, value);
  }

  @override
  List<String>? getSharedStringList(String key) {
    return prefs.getStringList(key);
  }

  @override
  Future<void> setSharedStringList(String key, List<String> value) {
    return prefs.setStringList(key, value);
  }


}