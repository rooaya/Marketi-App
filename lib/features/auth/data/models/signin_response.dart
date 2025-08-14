// lib/models/signin_response.dart

class SigninResponse {
  final String message;
  final String token;
  final User user;

  SigninResponse({required this.message, required this.token, required this.user});

  factory SigninResponse.fromJson(Map<String, dynamic> json) {
    return SigninResponse(
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String name;
  final String phone;
  final String email;
  final String role;
  final String image;

  User({
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      image: json['image'] ?? '',
    );
  }
}