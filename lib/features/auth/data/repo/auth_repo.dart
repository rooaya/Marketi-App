// import 'package:marketiapp/core/api/api_consumer.dart';
// import 'package:marketiapp/features/auth/data/models/reset_password_request.dart';
// import 'package:marketiapp/features/auth/data/models/reset_password_response.dart';
// import 'package:marketiapp/features/auth/data/models/send_verification_email_request.dart';
// import 'package:marketiapp/features/auth/data/models/send_verification_email_response.dart';
// import 'package:marketiapp/features/auth/data/models/signin_request.dart';
// import 'package:marketiapp/features/auth/data/models/signin_response.dart';
// import 'package:marketiapp/features/auth/data/models/signup_request.dart';
// import 'package:marketiapp/features/auth/data/models/signup_response.dart';

// class AuthRepo {
//   final ApiConsumer apiConsumer;

//   AuthRepo({required this.apiConsumer});

//   // Sign In
//   Future<SigninResponse> signIn(SigninRequest request) async {
//     try {
//       final response = await apiConsumer.signIn(request);
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // Sign Up
//   Future<SignupResponse> signUp(SignupRequest request) async {
//     try {
//       final response = await apiConsumer.signUp(request);
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // Request Password Reset Code
//   Future<ResetPasswordResponse> requestResetCode(ResetPasswordRequest request) async {
//     try {
//       final response = await apiConsumer.post(
//         '/auth/resetPassCode',
//         data: request.toJson(),
//       );
//       return ResetPasswordResponse.fromJson(response.data);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // Verify Reset Code
//   Future<ResetPasswordResponse> verifyResetCode({
//     required String email,
//     required String resetCode,
//   }) async {
//     try {
//       final response = await apiConsumer.post(
//         '/auth/activeResetPass',
//         data: {
//           'email': email,
//           'resetCode': resetCode,
//         },
//       );
//       return ResetPasswordResponse.fromJson(response.data);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // Reset Password
//   Future<ResetPasswordResponse> resetPassword({
//     required String email,
//     required String newPassword,
//     required String resetCode,
//   }) async {
//     try {
//       final response = await apiConsumer.post(
//         '/auth/resetPassword',
//         data: {
//           'email': email,
//           'newPassword': newPassword,
//           'resetCode': resetCode,
//         },
//       );
//       return ResetPasswordResponse.fromJson(response.data);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // Resend Verification Email
//   Future<SendVerificationEmailResponse> resendVerificationEmail(
//     SendVerificationEmailRequest request,
//   ) async {
//     try {
//       final response = await apiConsumer.post(
//         '/auth/resend-verification',
//         data: request.toJson(),
//       );
//       return SendVerificationEmailResponse.fromJson(response.data);
//     } catch (e) {
//       rethrow;
//     }
//   }
// }