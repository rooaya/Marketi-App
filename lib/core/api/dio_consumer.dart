import 'package:dio/dio.dart';
import 'package:marketiapp/core/api/api_interceptors.dart';
import 'api_consumer.dart';
import 'end_points.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;
  final Future<String?> Function() getToken;

  DioConsumer({
    required this.dio,
    required this.getToken,
  }) {
    dio.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.json
      ..receiveDataWhenStatusError = true;

    dio.interceptors.addAll([
      ApiInterceptor(getToken: getToken),
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    ]);
  }

  @override
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFromData ? _formDataConverter(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: isFromData ? _formDataConverter(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFromData ? _formDataConverter(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  FormData _formDataConverter(Object? data) {
    if (data == null) return FormData();
    if (data is Map<String, dynamic>) return FormData.fromMap(data);
    throw ArgumentError('Data must be a Map for form data conversion');
  }

  void _handleDioError(DioException error) {
    // Add your custom error handling logic here
    throw error;
  }
}