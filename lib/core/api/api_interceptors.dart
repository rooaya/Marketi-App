import 'package:dio/dio.dart';
import 'package:marketiapp/core/helpers/shared_preferences.dart';
import 'end_points.dart';

class ApiInterceptor extends Interceptor {
  ////! handle refresh/assess_token
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = CacheHelper.getData(key: StorageKeys.token);
    options.headers['Content-Type'] = 'application/json';
    options.headers[ApiKey.authorization] =
        // "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4OGRiZDkwZjk5ZThhYTQ1MWQ3YjdhMSIsImlhdCI6MTc1NTQxODkxOCwiZXhwIjoxNzU4MDEwOTE4fQ.xmuJmE-qRoCMFVoWQ3Ze0QQr5llNRP5xtGiSw6w5BWg";
        token != null ? 'Bearer $token' : null;
    super.onRequest(options, handler);
  }
}
