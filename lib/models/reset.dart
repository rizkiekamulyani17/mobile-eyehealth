class ResetModel {
  String email;
  String password;

  ResetModel({required this.email, required this.password});

  // Convert UserModel to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
