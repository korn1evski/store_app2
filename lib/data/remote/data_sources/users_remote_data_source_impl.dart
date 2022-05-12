import 'package:store_app/data/remote/data_sources/users_remote_data_source.dart';

import 'package:http/http.dart' as http;
import 'package:store_app/data/remote/dio_config.dart';
import 'package:store_app/data/remote/models/login_response_model.dart';
import 'package:store_app/data/remote/models/refresh_response_model.dart';
import 'package:dio/dio.dart';
import 'package:store_app/injection_container.dart' as di;

import '../../../domain/entities/account_info_entity.dart';

class UsersRemoteDataSourceImpl extends UsersRemoteDataSource {
  final String baseUrl = 'http://mobile-shop-api.hiring.devebs.net/users';
  final _dio = di.sl<Dio>();
  DioConfig dioConfig = DioConfig();

  @override
  Future<String> registerUser(String fullName, String email, String phoneNumber,
      String password) async {
    try {
      final response = await http.post(Uri.parse(baseUrl + '/register'), body: {
        "full_name": fullName,
        "email": email,
        "password": password,
        "phone_number": phoneNumber
      });
      if(response.statusCode == 201){
        return 'Now you are registered';
      } else if (response.statusCode == 400){
        return 'User with this email already exists';
      } else {
        return 'Error';
      }
    } catch (e) {
      print(e);
      return 'Error';
    }
  }

  @override
  Future<List<String>> login(String email, String password) async{
    try{
      final response = await http.post(Uri.parse(baseUrl + '/login'), body: {
        'email': email,
        'password' : password
      });
      if(response.statusCode == 200){
        final LoginResponseModel result = loginResponseModelFromJson(response.body);
        return [result.refresh, result.access];
      } else if (response.statusCode == 401){
        return ['No active account found with the given credentials'];
      } else {
        return ['Error'];
      }
    } catch(e){
      return ['Error'];
    }
  }

  @override
  Future<String> verifyLogin(String refreshToken) async{
   try{
     final response = await http.post(Uri.parse(baseUrl + '/refresh'), body: {
       'refresh': refreshToken
     });
     if(response.statusCode == 200){
       final RefreshResponseModel result = refreshResponseModelFromJson(response.body);
       return result.access;
     } else if (response.statusCode == 401){
       return '';
     } else {
       return '';
     }
   } catch(e){
     return '';
   }
  }

  @override
  Future<AccountInfoEntity> accountInfo(String accessToken) async{

    dioConfig.configureDio(accessToken);

    try {
      final response = await _dio.get(baseUrl + '/profile');

      if(response.statusCode == 200){
        return AccountInfoEntity(id: response.data['id'], fullName: response.data['full_name'], email: response.data['email'], phoneNumber: response.data['phone_number']);
      } else {
        return AccountInfoEntity(id: -1, fullName: '', phoneNumber: '', email: '');
      }
    } catch(e){
      return AccountInfoEntity(id: -1, fullName: '', phoneNumber: '', email: '');
    }
  }
}
