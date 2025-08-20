import 'package:marketiapp/core/resources/assets_manager.dart';

class UserState {}

final class UserInitial extends UserState {}

// Authentication States
final class SignInSuccess extends UserState {}
final class SignInLoading extends UserState {}
final class SignInFailure extends UserState {
  final String errMessage;
  SignInFailure({required this.errMessage});
}

final class SignUpSuccess extends UserState {
  final String message;
  SignUpSuccess({required this.message});
}
final class SignUpLoading extends UserState {}
final class SignUpFailure extends UserState {
  final String errMessage;
  SignUpFailure({required this.errMessage});
}

final class ResetPasswordSuccess extends UserState {}
final class ResetPasswordLoading extends UserState {}
final class ResetPasswordFailure extends UserState {
  final String errMessage;
  ResetPasswordFailure({required this.errMessage});
}

// Profile States
final class GetUserSuccess extends UserState {
  final Map<String, dynamic> userData;
  GetUserSuccess({required this.userData});
}
final class GetUserLoading extends UserState {}
final class GetUserFailure extends UserState {
  final String errMessage;
  GetUserFailure({required this.errMessage});
}

// Search States
final class SearchLoading extends UserState {}
final class SearchSuccess extends UserState {
  final List<dynamic> results;
  SearchSuccess({required this.results});
}
final class SearchFailure extends UserState {
  final String errMessage;
  SearchFailure({required this.errMessage});
}
final class SearchEmpty extends UserState {
  final String emptyImagePath;
  SearchEmpty({this.emptyImagePath = AppAssets.placeholder});
}