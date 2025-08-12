// lib/models/signin_request.dart

class SigninRequest {
  final String email;
  final String password;

  SigninRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}