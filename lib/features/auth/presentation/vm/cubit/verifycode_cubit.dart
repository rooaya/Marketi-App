// // features/auth/presentation/vm/VerifyCode/verify_cubit.dart
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:marketiapp/core/api/api_consumer.dart';
// import 'package:marketiapp/core/api/end_points.dart';
// import 'package:marketiapp/features/auth/data/repo/auth_repo.dart';


// class VerifyCubit extends Cubit<VerifyState> {
//   final AuthRepo authRepo;

//   VerifyCubit({required this.authRepo}) : super(VerifyInitial());

//   Future<void> verifyResetCode(String email, String code) async {
//     emit(VerifyLoading());
//     try {
//       final response = await authRepo.api.post(
//         EndPoints.activeResetPass,
//         data: {'email': email, 'code': code},
//       );

//       if (response.statusCode == 200) {
//         emit(VerifySuccess('Verification successful!'));
//       } else {
//         emit(VerifyFailure('Verification failed. Please check the code.'));
//       }
//     } on DioException catch (e) {
//       final errorMessage = e.response?.data['message'] ?? e.message ?? 'Verification failed';
//       emit(VerifyFailure(errorMessage));
//     } catch (e) {
//       emit(VerifyFailure('An unexpected error occurred'));
//     }
//   }

//   Future<void> resendVerificationCode(String email) async {
//     emit(VerifyResendLoading());
//     try {
//       final response = await authRepo.api.post(
//         EndPoints.resetPassword,
//         data: {'email': email},
//       );

//       if (response.statusCode == 200) {
//         emit(VerifyResendSuccess('Verification code resent successfully!'));
//       } else {
//         emit(VerifyResendFailure('Failed to resend verification code.'));
//       }
//     } on DioException catch (e) {
//       final errorMessage = e.response?.data['message'] ?? e.message ?? 'Failed to resend code';
//       emit(VerifyResendFailure(errorMessage));
//     } catch (e) {
//       emit(VerifyResendFailure('An unexpected error occurred'));
//     }
//   }
// }