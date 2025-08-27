// sign_up_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:marketiapp/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';
import 'package:marketiapp/core/errors/failure.dart';
import 'package:marketiapp/features/auth/data/models/SignUp/signup_request.dart';
import 'package:marketiapp/features/auth/data/models/SignUp/signup_response.dart';


part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo authRepo;
  
  SignUpCubit({required this.authRepo}) : super(SignUpInitial());

  Future<void> signUp({
    required String name,
    required String username,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(SignUpLoading());
    
    if (password != confirmPassword) {
      emit(SignUpFailure(error: 'Passwords do not match'));
      return;
    }
    
    final request = SignupRequest(
      name: name,
      username: username,
      phone: phone,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    
    final result = await authRepo.signUp(body: request);
    
    result.fold(
      (failure) {
        emit(SignUpFailure(error: _mapFailureToMessage(failure)));
      },
      (signupResponse) {
        emit(SignUpSuccess(signupResponse: signupResponse));
      },
    );
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