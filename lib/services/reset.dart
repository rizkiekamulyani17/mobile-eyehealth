import 'dart:convert';
import 'package:Eye_Health/models/api.dart';
import 'package:http/http.dart' as http;

class ResetService {
  final ApiService _api = ApiService();
  Future<bool> sendResetPasswordEmail(String email) async {
    String baseUrl = await _api.getBaseUrl();
    final url = Uri.parse("${baseUrl}/api/user/forgot/");
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 200) {
        // Successfully sent email
        return true;
      } else {
        // Error occurred
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("Error: ${responseData["message"] ?? "Unknown error"}");
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }
}
