import 'package:dio/dio.dart';
import 'package:marketiapp/models/signin_request.dart';
import 'package:marketiapp/models/signin_response.dart';
import 'package:marketiapp/models/signup_request.dart';
import 'package:marketiapp/models/signup_response.dart';

class ApiConsumer {
  final Dio dio;

ApiConsumer({required this.dio});

  Future<SignupResponse> signUp(SignupRequest request) async {
    try {
      final response = await dio.post(
        'https://supermarket-dan1.onrender.com/api/v1/auth/signup',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return SignupResponse.fromJson(response.data);
      } else {
        throw Exception('Signup failed: ${response.data}');
      }
    } catch (e) {
      throw Exception('Error during signup: $e');
    }
  }

  Future<SigninResponse> signIn(SigninRequest request) async {
    try {
      final response = await dio.post(
        'https://supermarket-dan1.onrender.com/api/v1/auth/signin',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return SigninResponse.fromJson(response.data);
      } else {
        throw Exception('Signin failed: ${response.data}');
      }
    } catch (e) {
      throw Exception('Error during signin: $e');
    }
  }
}