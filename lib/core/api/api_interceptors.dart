import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  final String? token;

  ApiInterceptors({this.token});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    // Logging request
    print('Request [${options.method}] => URL: ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Logging response
    print('Response [${response.statusCode}] => Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // Handle specific error status codes
    if (err.response != null) {
      final statusCode = err.response?.statusCode;
      if (statusCode == 401) {
        // Handle token expiration or unauthorized access
        print('Unauthorized - possibly refresh token or redirect to login.');
      } else {
        print('Error [${statusCode}]: ${err.response?.data}');
      }
    } else {
      print('Error: ${err.message}');
    }
    super.onError(err, handler);
  }
}