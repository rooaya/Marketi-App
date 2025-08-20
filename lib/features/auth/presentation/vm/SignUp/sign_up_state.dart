// sign_up_state.dart
part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final SignupResponse signupResponse;
  
  SignUpSuccess({required this.signupResponse});
}

final class SignUpFailure extends SignUpState {
  final String error;
  
  SignUpFailure({required this.error});
}