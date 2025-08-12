class VerifyCodeRequest {
  final String email; // or phoneNumber
  final String code;

  VerifyCodeRequest({required this.email, required this.code});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'code': code,
    };
  }
}