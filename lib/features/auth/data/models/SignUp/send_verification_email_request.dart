class SendVerificationEmailRequest {
  final String email;

  SendVerificationEmailRequest({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}