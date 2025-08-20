class SendVerificationEmailResponse {
  final bool success;
  final String? message;

  SendVerificationEmailResponse({required this.success, this.message});

  factory SendVerificationEmailResponse.fromJson(Map<String, dynamic> json) {
    return SendVerificationEmailResponse(
      success: json['success'] ?? false,
      message: json['message'],
    );
  }
}
