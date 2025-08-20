// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:marketiapp/core/api/api_consumer.dart';
// import 'package:marketiapp/core/api/end_points.dart';
// import 'package:marketiapp/core/errors/error_model.dart';
// import 'package:marketiapp/features/auth/presentation/vm/user_state.dart';

// class UserCubit extends Cubit<UserState> {
//   final ApiConsumer apiConsumer;

//   UserCubit({required this.apiConsumer}) : super(UserInitial());

//   // Authentication Controllers
//   GlobalKey<FormState> signInFormKey = GlobalKey();
//   TextEditingController signInEmail = TextEditingController();
//   TextEditingController signInPassword = TextEditingController();

//   GlobalKey<FormState> signUpFormKey = GlobalKey();
//   TextEditingController signUpName = TextEditingController();
//   TextEditingController signUpPhoneNumber = TextEditingController();
//   TextEditingController signUpEmail = TextEditingController();
//   TextEditingController signUpPassword = TextEditingController();
//   TextEditingController confirmPassword = TextEditingController();
//   XFile? profilePic;

//   // Reset Password Controllers
//   GlobalKey<FormState> resetPasswordFormKey = GlobalKey();
//   TextEditingController resetPasswordEmail = TextEditingController();
//   TextEditingController resetPasswordCode = TextEditingController();
//   TextEditingController newPassword = TextEditingController();
//   TextEditingController confirmNewPassword = TextEditingController();

//   // Search Controller
//   TextEditingController searchController = TextEditingController();

//   // Authentication Methods
//   Future<void> signIn() async {
//     emit(SignInLoading());
//     try {
//       final response = await apiConsumer.post(
//         EndPoints.signIn,
//         data: {'email': signInEmail.text, 'password': signInPassword.text},
//       );
//       emit(SignInSuccess());
//     } on DioException catch (e) {
//       final errorModel = ErrorModel.fromJson(e.response?.data ?? {});
//       emit(SignInFailure(errMessage: errorModel.message.));
//     } catch (e) {
//       emit(SignInFailure(errMessage: e.toString()));
//     }
//   }

//   Future<void> signUp() async {
//     emit(SignUpLoading());
//     try {
//       final response = await apiConsumer.post(
//         EndPoints.signUp,
//         data: {
//           'name': signUpName.text,
//           'phone': signUpPhoneNumber.text,
//           'email': signUpEmail.text,
//           'password': signUpPassword.text,
//           'confirmPassword': confirmPassword.text,
//         },
//         isFromData: profilePic != null,
//       );
//       emit(SignUpSuccess(message: response['message']));
//     } on DioException catch (e) {
//       final errorModel = ErrorModel.fromJson(e.response?.data ?? {});
//       emit(SignUpFailure(errMessage: errorModel.message));
//     } catch (e) {
//       emit(SignUpFailure(errMessage: e.toString()));
//     }
//   }

//   Future<void> resetPassword() async {
//     emit(ResetPasswordLoading());
//     try {
//       final response = await apiConsumer.post(
//         EndPoints.resetPass,
//         data: {'email': resetPasswordEmail.text},
//       );
//       emit(ResetPasswordSuccess());
//     } on DioException catch (e) {
//       final errorModel = ErrorModel.fromJson(e.response?.data ?? {});
//       emit(ResetPasswordFailure(errMessage: errorModel.message));
//     } catch (e) {
//       emit(ResetPasswordFailure(errMessage: e.toString()));
//     }
//   }

//   Future<void> confirmResetPassword() async {
//     emit(ResetPasswordLoading());
//     try {
//       final response = await apiConsumer.post(
//         EndPoints.activeResetPass,
//         data: {'code': resetPasswordCode.text},
//       );
//       emit(ResetPasswordSuccess());
//     } on DioException catch (e) {
//       final errorModel = ErrorModel.fromJson(e.response?.data ?? {});
//       emit(ResetPasswordFailure(errMessage: errorModel.message));
//     } catch (e) {
//       emit(ResetPasswordFailure(errMessage: e.toString()));
//     }
//   }

//   Future<void> updatePassword() async {
//     emit(ResetPasswordLoading());
//     try {
//       final response = await apiConsumer.post(
//         EndPoints.resetPass,
//         data: {
//           'newPassword': newPassword.text,
//           'confirmNewPassword': confirmNewPassword.text,
//         },
//       );
//       emit(ResetPasswordSuccess());
//     } on DioException catch (e) {
//       final errorModel = ErrorModel.fromJson(e.response?.data ?? {});
//       emit(ResetPasswordFailure(errMessage: errorModel.message));
//     } catch (e) {
//       emit(ResetPasswordFailure(errMessage: e.toString()));
//     }
//   }

//   // Profile Methods
//   Future<void> getUserData() async {
//     emit(GetUserLoading());
//     try {
//       final response = await apiConsumer.get(EndPoints.userData);
//       emit(GetUserSuccess(userData: response));
//     } on DioException catch (e) {
//       final errorModel = ErrorModel.fromJson(e.response?.data ?? {});
//       emit(GetUserFailure(errMessage: errorModel.errorMessage));
//     } catch (e) {
//       emit(GetUserFailure(errMessage: e.toString()));
//     }
//   }

//   // Search Methods
//   Future<void> search(String query) async {
//     if (query.isEmpty) {
//       emit(SearchEmpty());
//       return;
//     }

//     emit(SearchLoading());
//     try {
//       final response = await apiConsumer.get(
//         '/search',
//         queryParameters: {'query': query},
//       );

//       if (response['results'] != null &&
//           (response['results'] as List).isNotEmpty) {
//         emit(SearchSuccess(results: response['results']));
//       } else {
//         emit(SearchEmpty());
//       }
//     } on DioException catch (e) {
//       final errorModel = ErrorModel.fromJson(e.response?.data ?? {});
//       emit(SearchFailure(errMessage: errorModel.errorMessage));
//     } catch (e) {
//       emit(SearchFailure(errMessage: e.toString()));
//     }
//   }

//   @override
//   Future<void> close() {
//     signInEmail.dispose();
//     signInPassword.dispose();
//     signUpName.dispose();
//     signUpPhoneNumber.dispose();
//     signUpEmail.dispose();
//     signUpPassword.dispose();
//     confirmPassword.dispose();
//     resetPasswordEmail.dispose();
//     resetPasswordCode.dispose();
//     newPassword.dispose();
//     confirmNewPassword.dispose();
//     searchController.dispose();
//     return super.close();
//   }
// }
