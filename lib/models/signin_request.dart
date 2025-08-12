// lib/models/signin_request.dart

class SigninRequest {
  final String email;
  final String password;

  SigninRequest({
    required this.email,
    required this.password,
  });

  /// Converts this SigninRequest into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}