class ResponseModel {
  String? status;
  String? message;
  String? role;
  dynamic? error; // error can be a Map<String, String> or String
  String? token;

  ResponseModel({
    this.status,
    this.message,
    this.role,
    this.error,
    this.token,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      status: json["status"],
      message: json["message"],
      role: json["role"],
      token: json["token"],
      error: json["error"], // This can be a map or a string
    );
  }
}
