// forgot_pass_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:marketiapp/features/auth/data/models/ResetPass/reset_password_response.dart';
import 'package:marketiapp/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:marketiapp/core/errors/failure.dart';

part 'forgot_pass_state.dart';

class ForgotPassCubit extends Cubit<ForgotPassState> {
  final AuthRepo authRepo;
  
  ForgotPassCubit({required this.authRepo}) : super(ForgotPassInitial());

  Future<void> sendResetCode(String email) async {
    emit(ForgotPassLoading());
    
    try {
      final response = await authRepo.sendResetCode(email: email);
      
      response.fold(
        (failure) {
          emit(ForgotPassFailure(error: _mapFailureToMessage(failure)));
        },
        (resetResponse) {
          emit(ForgotPassSuccess(resetResponse: resetResponse));
        },
      );
    } catch (e) {
      emit(ForgotPassFailure(error: 'An unexpected error occurred'));
    }
  }

  Future<void> resendVerificationEmail(String email) async {
    emit(ForgotPassLoading());
    
    try {
      final response = await authRepo.resendVerificationEmail(email: email);
      
      response.fold(
        (failure) {
          emit(ForgotPassResendFailure(error: _mapFailureToMessage(failure)));
        },
        (success) {
          emit(ForgotPassResendSuccess());
        },
      );
    } catch (e) {
      emit(ForgotPassResendFailure(error: 'An unexpected error occurred'));
    }
  }
  
  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.errorModel.message ?? 'Server error occurred';
    } else if (failure is NetworkFailure) {
      return 'Network connection failed';
    } else if (failure is NotFoundFailure) {
      return 'Resource not found';
    } else {
      return 'An unexpected error occurred';
    }
  }
}