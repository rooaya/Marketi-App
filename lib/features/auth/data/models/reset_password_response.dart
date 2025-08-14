class ResetPasswordResponse {
  final bool success;
  final String? message;
  final String? code;

  ResetPasswordResponse({required this.success, this.message,this.code});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      success: json['success'] ?? false,
      message: json['message'],
      code: json['code'] ?? json['resetCode'],
    );
  }
}
