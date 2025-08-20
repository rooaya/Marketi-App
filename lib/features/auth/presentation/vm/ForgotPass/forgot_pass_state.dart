// forgot_pass_state.dart
part of 'forgot_pass_cubit.dart';

@immutable
sealed class ForgotPassState {}

final class ForgotPassInitial extends ForgotPassState {}

final class ForgotPassLoading extends ForgotPassState {}

final class ForgotPassSuccess extends ForgotPassState {
  final ResetPasswordResponse resetResponse;
  
  ForgotPassSuccess({required this.resetResponse});
}

final class ForgotPassFailure extends ForgotPassState {
  final String error;
  
  ForgotPassFailure({required this.error});
}

final class ForgotPassResendSuccess extends ForgotPassState {}

final class ForgotPassResendFailure extends ForgotPassState {
  final String error;
  
  ForgotPassResendFailure({required this.error});
}