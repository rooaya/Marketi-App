// lib/models/signup_response.dart

class SignupResponse {
  final String message;
  final User user;

  SignupResponse({required this.message, required this.user});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      message: json['message'] ?? '',
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