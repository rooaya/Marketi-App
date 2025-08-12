// lib/services/dio_consumer.dart

import 'package:dio/dio.dart';
import 'package:marketiapp/core/api/end_points.dart';


class DioConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<Response> post(String endpoint, {Map<String, dynamic>? data, String? token}) async {
    try {
      final options = Options(
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );
      final response = await dio.post(endpoint, data: data, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> get(String endpoint, {String? token}) async {
    try {
      final options = Options(
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );
      final response = await dio.get(endpoint, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}