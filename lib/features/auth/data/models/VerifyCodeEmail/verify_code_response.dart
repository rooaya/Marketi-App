class VerifyCodeResponse {
  final bool success;
  final String? message;
  final String? token; // if your API returns a token upon verification

  VerifyCodeResponse({required this.success, this.message, this.token});

  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) {
    return VerifyCodeResponse(
      success: json['success'] ?? false,
      message: json['message'],
      token: json['token'], // optional, depending on your API
    );
  }
}