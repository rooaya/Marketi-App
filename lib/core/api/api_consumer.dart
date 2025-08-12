import 'package:dio/dio.dart';
import 'package:marketiapp/core/api/dio_consumer.dart';
import 'package:marketiapp/core/api/end_points.dart';
import 'package:marketiapp/models/send_verification_email_request.dart';
import 'package:marketiapp/models/send_verification_email_response.dart';
import 'package:marketiapp/models/signin_request.dart';
import 'package:marketiapp/models/signin_response.dart';
import 'package:marketiapp/models/signup_request.dart';
import 'package:marketiapp/models/signup_response.dart';
import 'package:marketiapp/models/verify_code_request.dart';
import 'package:marketiapp/models/verify_code_response.dart';

class ApiConsumer {
  final Dio dio;
  late final DioConsumer dioConsumer;

  ApiConsumer({required this.dio}) {
    dioConsumer = DioConsumer(dio: dio);
  }

  // Sign In
  Future<SigninResponse> signIn(SigninRequest request) async {
    final response = await dioConsumer.post(
      EndPoints.signIn,
      data: request.toJson(),
    );
    return SigninResponse.fromJson(response.data);
  }

  // Sign Up
  Future<SignupResponse> signUp(SignupRequest request) async {
    final response = await dioConsumer.post(
      EndPoints.signUp,
      data: request.toJson(),
    );
    return SignupResponse.fromJson(response.data);
  }

  // Send Verification Email (assuming resetPass endpoint is used for this purpose)
  Future<SendVerificationEmailResponse> sendVerificationEmail(
      SendVerificationEmailRequest request) async {
    final response = await dioConsumer.post(
      EndPoints.resetpass, // Verify if this is correct for your API
      data: request.toJson(),
    );
    return SendVerificationEmailResponse.fromJson(response.data);
  }

  // Verify Code
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest request) async {
    final response = await dioConsumer.post(
      EndPoints.verifyCode, // Ensure this exists in your EndPoints
      data: request.toJson(),
    );
    return VerifyCodeResponse.fromJson(response.data);
  }

  // Add other methods as needed, e.g., password reset, user data, etc.
}