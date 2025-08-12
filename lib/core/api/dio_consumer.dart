import 'package:dio/dio.dart';
import 'package:marketiapp/core/api/end_points.dart';

class DioConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    // You can add your ApiInterceptors here if needed
    // dio.interceptors.add(ApiInterceptors(token: 'your_token'));
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
      // Handle errors more gracefully if needed
      // For now, rethrowing
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

  // Optional: add update, delete, put methods
  Future<Response> put(String endpoint, {Map<String, dynamic>? data, String? token}) async {
    try {
      final options = Options(
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );
      final response = await dio.put(endpoint, data: data, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String endpoint, {String? token}) async {
    try {
      final options = Options(
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );
      final response = await dio.delete(endpoint, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}