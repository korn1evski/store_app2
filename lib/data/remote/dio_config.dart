import 'package:dio/dio.dart';
import 'package:store_app/injection_container.dart' as di;

class DioConfig{
  final _dio = di.sl<Dio>();

  void configureDio(String accessToken){
    _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler){
    options.headers['Authorization'] = 'Token $accessToken';
    return handler.next(options);
    }));
  }
}