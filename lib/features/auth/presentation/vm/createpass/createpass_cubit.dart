// createpass_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:marketiapp/core/api/api_consumer.dart';
import 'package:marketiapp/core/errors/failure.dart';
import 'package:marketiapp/features/auth/data/repo/auth_repo.dart';

part 'createpass_state.dart';

class CreatepassCubit extends Cubit<CreatepassState> {
  final AuthRepo authRepo;
  final String email;
  
  CreatepassCubit({
    required this.authRepo,
    required this.email,
  }) : super(CreatepassInitial());

  Future<void> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(CreatepassLoading());
    
    if (newPassword != confirmPassword) {
      emit(CreatepassFailure(error: 'Passwords do not match'));
      return;
    }
    
    try {
      final response = await authRepo.resetPassword(
        email: email,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      
      response.fold(
        (failure) {
          emit(CreatepassFailure(error: _mapFailureToMessage(failure)));
        },
        (success) {
          emit(CreatepassSuccess());
        },
      );
    } catch (e) {
      emit(CreatepassFailure(error: 'An unexpected error occurred'));
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