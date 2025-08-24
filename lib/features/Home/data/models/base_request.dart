class BaseRequest {
  final String token;

  BaseRequest({required this.token});

  Map<String, String> toHeaders() {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }
}