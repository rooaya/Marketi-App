// lib/services/api_consumer.dart

import 'package:dio/dio.dart';
import 'package:marketiapp/core/api/dio_consumer.dart';
import 'package:marketiapp/core/api/end_points.dart';
import 'package:marketiapp/models/signin_request.dart';
import 'package:marketiapp/models/signin_response.dart';
import 'package:marketiapp/models/signup_request.dart';
import 'package:marketiapp/models/signup_response.dart';



class ApiConsumer {
  final Dio dio;

  late final DioConsumer dioConsumer;

  ApiConsumer({required this.dio}) {
    dioConsumer = DioConsumer(dio: dio);
  }

  Future<SigninResponse> signIn(SigninRequest request) async {
    final response = await dioConsumer.post(
      EndPoints.signIn,
      data: request.toJson(),
    );
    return SigninResponse.fromJson(response.data);
  }

  Future<SignupResponse> signUp(SignupRequest request) async {
    final response = await dioConsumer.post(
      EndPoints.signUp,
      data: request.toJson(),
    );
    return SignupResponse.fromJson(response.data);
  }
}