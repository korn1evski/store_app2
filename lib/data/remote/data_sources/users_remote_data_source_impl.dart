import 'package:store_app/data/remote/data_sources/users_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/data/remote/models/login_response_model.dart';
import 'package:store_app/data/remote/models/refresh_response_model.dart';
import 'package:dio/dio.dart';

import '../../../domain/entities/account_info_entity.dart';

class UsersRemoteDataSourceImpl extends UsersRemoteDataSource {
  final String baseUrl = 'http://mobile-shop-api.hiring.devebs.net/users';
  UsersRemoteDataSourceImpl({required this.authDio});
  final Dio authDio;

  @override
  Future<int> registerUser(String fullName, String email, String phoneNumber,
      String password, String profilePicture) async {
    try {
      final response = await http.post(Uri.parse(baseUrl + '/register'), body: {
        "full_name": fullName,
        "email": email,
        "password": password,
        "phone_number": phoneNumber,
        "profile_picture": profilePicture
      });
      if(response.statusCode == 201){
        return 201;
      } else if (response.statusCode == 400){
        return 400;
      } else {
        return 400;
      }
    } catch (e) {
      return 400;
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
  Future<AccountInfoEntity?> accountInfo() async{


    try {
      final response = await authDio.get(baseUrl + '/profile');

      if(response.statusCode == 200){
        return AccountInfoEntity(id: response.data['id'], fullName: response.data['full_name'], email: response.data['email'], phoneNumber: response.data['phone_number'], profilePicture: response.data['profile_picture']);
      } else {
        return null;
      }
    } catch(e){
      return null;
    }
  }
}
