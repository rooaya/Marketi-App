import 'package:marketiapp/models/signin_request.dart';
import 'package:marketiapp/models/signin_response.dart';
import 'package:marketiapp/models/signup_request.dart';
import 'package:marketiapp/models/signup_response.dart';
import 'package:marketiapp/models/send_verification_email_request.dart';
import 'package:marketiapp/models/send_verification_email_response.dart';
import 'package:marketiapp/core/api/api_consumer.dart';

class AuthRepo {
  final ApiConsumer apiConsumer;

  AuthRepo({required this.apiConsumer});

  // Sign In
  Future<SigninResponse> signIn(SigninRequest request) async {
    try {
      final response = await apiConsumer.signIn(request);
      return response;
    } catch (e) {
      // Handle exceptions or rethrow
      rethrow;
    }
  }

  // Sign Up
  Future<SignupResponse> signUp(SignupRequest request) async {
    try {
      final response = await apiConsumer.signUp(request);
      return response;
    } catch (e) {
      // Handle exceptions or rethrow
      rethrow;
    }
  }

  // Send Verification Email
  Future<SendVerificationEmailResponse> sendVerificationEmail(
      SendVerificationEmailRequest request) async {
    try {
      final response = await apiConsumer.sendVerificationEmail(request);
      return response;
    } catch (e) {
      // Handle exceptions or rethrow
      rethrow;
    }
  }
}