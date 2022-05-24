import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:store_app/core/interceptors/dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({required this.requestRetrier});

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      return requestRetrier.scheduleRequestRetry(err, handler);
    }
    return super.onError(err, handler);
  }

  bool _shouldRetry(DioError error) {
    return error.error != null && error.error is SocketException;
  }
}
