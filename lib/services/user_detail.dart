import 'dart:convert';
import 'package:Eye_Health/models/api.dart';
import 'package:Eye_Health/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserDetail {
  final ApiService _api = ApiService(); // Replace with your actual base URL

  // Fetch user details
  Future<UserModel> getUserDetails() async {
    try {
      // Get token from shared preferences
      String baseUrl = await _api.getBaseUrl();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found');
      }
      print("$baseUrl/api/user-details");
      final response = await http.get(
        Uri.parse("$baseUrl/api/user-details"),
        headers: {
          'Content-Type': 'application/json',
          'X-Token': 'Bearer $token', // Include token in the headers
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return UserModel.fromJson(data); // Deserialize the user data
      } else {
        throw Exception('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load user data: $e');
    }
  }

  // Change password
  Future<bool> changePassword(String currentPassword, String newPassword,
      String confirmPassword) async {
    String baseUrl = await _api.getBaseUrl();
    // Get token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('No token found');
    }

    // Send the password change request
    final response = await http.put(
      Uri.parse("$baseUrl/api/change-password"),
      headers: {
        'Content-Type': 'application/json',
        'X-Token': 'Bearer $token', // Include token in the headers
      },
      body: jsonEncode({
        'current_password': currentPassword,
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      }),
    );

    // Check response status
    if (response.statusCode == 200) {
      // Success
      return true;
    } else {
      // If the server returns an error message in the response body
      final responseBody = jsonDecode(response.body);
      String errorMessage = responseBody['error'];

      throw (errorMessage);
    }
  }
}
