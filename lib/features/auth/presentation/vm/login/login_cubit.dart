import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/core/errors/failure.dart';
import 'package:marketiapp/features/auth/data/models/Signin/signin_request.dart';
import 'package:marketiapp/features/auth/data/repo/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;
  LoginCubit({required this.authRepo}) : super(LoginInitial());

  Future<void> signIn(SigninRequest body) async {
    emit(LoginLoading());
    final response = await authRepo.signIn(body: body);
    response.fold(
      (failure) => emit(LoginFailure(failure)),
      (success) => emit(LoginSuccess(success)),
    );
  }
}
