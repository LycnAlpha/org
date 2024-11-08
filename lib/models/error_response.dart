class ErrorResponse {
  String status;
  String exceptionCode;
  String error;

  ErrorResponse({
    required this.status,
    required this.exceptionCode,
    required this.error,
  });

  factory ErrorResponse.fromJson(dynamic json) {
    return ErrorResponse(
      status: json['status'],
      exceptionCode: json['exceptionCode'],
      error: json['error'],
    );
  }
}
