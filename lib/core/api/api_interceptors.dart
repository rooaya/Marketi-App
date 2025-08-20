import 'package:dio/dio.dart';
import 'package:marketiapp/core/helpers/shared_preferences.dart';
import 'end_points.dart';

class ApiInterceptor extends Interceptor {
  ////! handle refresh/assess_token
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = CacheHelper().getData(key: StorageKeys.token);
    options.headers['Content-Type'] = 'application/json';
    options.headers[ApiKey.authorization] =
        // "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4NDJmM2M2ZGZiNDAwNjRmMmNhZGRkMiIsImlhdCI6MTc0OTI5NDQyOH0.dB3U4izjI_kdNqPzv_A86OdRAgI29WM4nmJIqGQdE9k";
        token != null ? 'Bearer $token' : null;
    super.onRequest(options, handler);
  }
}