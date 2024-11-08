class APIResponse {
  String? code;
  String? message;
  dynamic data;

  APIResponse({
    required this.code,
    required this.message,
    this.data,
  });

  factory APIResponse.fromJson(dynamic json) {
    return APIResponse(
      code: json['code'],
      message: json['message'],
      data: json['data'],
    );
  }
}
