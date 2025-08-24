// auth_repo.dart
import 'package:dartz/dartz.dart';
import 'package:marketiapp/core/api/api_consumer.dart';
import 'package:marketiapp/core/errors/error_model.dart';
import 'package:marketiapp/core/errors/exceptions.dart';
import 'package:marketiapp/core/errors/failure.dart';
import 'package:marketiapp/core/helpers/shared_preferences.dart';
import 'package:marketiapp/features/auth/data/models/Signin/signin_request.dart';
import 'package:marketiapp/features/auth/data/models/Signin/signin_response.dart';
import 'package:marketiapp/features/auth/data/models/SignUp/signup_request.dart';
import 'package:marketiapp/features/auth/data/models/SignUp/signup_response.dart';
import 'package:marketiapp/features/auth/data/models/ResetPass/reset_password_response.dart';
import '../../../../core/api/end_points.dart';

class AuthRepo {
  final ApiConsumer api;
  AuthRepo({required this.api});

  Future<Either<Failure, SigninResponse>> signIn({
    required SigninRequest body,
  }) async {
    try {
      final response = await api.post(EndPoints.signIn, data: body.toJson());
      final signInResponse = SigninResponse.fromJson(response);
      
      await CacheHelper.saveData(
        key: StorageKeys.token,
        value: signInResponse.token,
      );

      return Right(signInResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(e.toString())));
    }
  }

  Future<Either<Failure, SignupResponse>> signUp({
    required SignupRequest body,
  }) async {
    try {
      final response = await api.post(EndPoints.signUp, data: body.toJson());
      final signUpResponse = SignupResponse.fromJson(response);
      
      return Right(signUpResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(e.toString())));
    }
  }

  // Forgot Password - Send Reset Code
  Future<Either<Failure, ResetPasswordResponse>> sendResetCode({
    required String email,
  }) async {
    try {
      final response = await api.post(
        EndPoints.sendPassEmail,
        data: {'email': email},
      );
      final resetResponse = ResetPasswordResponse.fromJson(response);
      
      return Right(resetResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(e.toString())));
    }
  }

  // Forgot Password - Resend Verification Email
  Future<Either<Failure, bool>> resendVerificationEmail({
    required String email,
  }) async {
    try {
      await api.post(
        '${EndPoints.baseUrl}auth/resend-verification',
        data: {'email': email},
      );
      
      return Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(e.toString())));
    }
  }

  // Verify Reset Code
  Future<Either<Failure, ResetPasswordResponse>> verifyResetCode({
    required String email,
    required String code,
  }) async {
    try {
      final response = await api.post(
        EndPoints.activeResetPass,
        data: {'email': email, 'code': code},
      );
      final resetResponse = ResetPasswordResponse.fromJson(response);
      
      return Right(resetResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(e.toString())));
    }
  }

  // Reset Password (after verification)
  Future<Either<Failure, bool>> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      await api.post(
        EndPoints.resetPassword,
        data: {
          'email': email,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        },
      );
      
      return Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(e.toString())));
    }
  }
}