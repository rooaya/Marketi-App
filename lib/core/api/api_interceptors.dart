// lib/services/api_interceptors.dart

import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  final String? token;

  ApiInterceptors({this.token});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // You can handle global response here
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // Handle errors globally
    super.onError(err, handler);
  }
}