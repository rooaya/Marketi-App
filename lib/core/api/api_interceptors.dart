import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  final Future<String?> Function() getToken;

  ApiInterceptor({required this.getToken});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await getToken();
      if (token != null) {
        options.headers['Authorization'] = 'FOODAPI $token';
      }
      handler.next(options);
    } catch (e) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'Failed to add authorization token',
          stackTrace: StackTrace.current,
        ),
        true,
      );
    }
  }
}