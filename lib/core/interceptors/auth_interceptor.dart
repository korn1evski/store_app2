
import 'package:dio/dio.dart';
import 'package:store_app/domain/use_cases/get_shared_string_usecase.dart';

class AuthInterceptor extends Interceptor {

  final GetSharedStringUseCase getSharedStringUseCase;

  AuthInterceptor({required this.getSharedStringUseCase});

  @override
  void onRequest(options, handler){
      final accessToken = getSharedStringUseCase.call('accessToken');
      if (accessToken != null || accessToken != '') {
        options.headers['Authorization'] =
        'Token $accessToken';
        return handler.next(options);
      } else {
        return handler.next(options);
      }
  }
}
