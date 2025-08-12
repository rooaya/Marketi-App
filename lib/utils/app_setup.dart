// lib/utils/app_setup.dart

import 'package:dio/dio.dart';

Dio createDio() {
  final dio = Dio();
  // You can add interceptors here if needed
  return dio;
}