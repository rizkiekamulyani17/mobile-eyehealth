import 'dart:convert';

import 'package:Eye_Health/models/response.dart';
import 'package:Eye_Health/services/session.dart';
import 'package:http/http.dart' as http;
import '../models/api.dart';

class AuthService {
  final SessionService _sessionService = SessionService();
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> register(
      String name,
      String email,
      String password,
      String tempat,
      String tanggalLahir,
      String alamat) async {
    String baseUrl = await _api.getBaseUrl();
    final response = await http.post(
      Uri.parse("$baseUrl/api/register"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'tempat': tempat,
        'tanggal_lahir': tanggalLahir,
        'alamat': alamat,
      }),
    );

    if (response.statusCode == 201) {
      // Success: Parse response and save session
      ResponseModel res = ResponseModel.fromJson(jsonDecode(response.body));
      await _saveSession(res); // Save session if necessary
      return {'status': true, 'message': res.message};
    } else if (response.statusCode == 409) {
      // Conflict error (duplicate email)
      ResponseModel res = ResponseModel.fromJson(jsonDecode(response.body));
      return {
        'status': false,
        'error': res.error ?? 'An error occurred',
      };
    } else {
      // Handle other errors
      throw Exception(
          "Failed to register. Status code: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    String baseUrl = await _api.getBaseUrl();
    final response = await http.post(
      Uri.parse("$baseUrl/api/login"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    // Handle successful response (200)
    if (response.statusCode == 200) {
      ResponseModel res = ResponseModel.fromJson(jsonDecode(response.body));
      await _saveSession(res); // Assuming this saves session data (like token)
      return {'status': true, 'message': res.message};
    }

    // Handle authentication errors (401)
    else if (response.statusCode == 401) {
      ResponseModel res = ResponseModel.fromJson(jsonDecode(response.body));

      // Check if 'error' is a map and contains 'email' or 'password' keys
      if (res.error != null && res.error is Map) {
        Map<String, dynamic> errorMap = res.error as Map<String, dynamic>;

        // Handle 'email' error if present
        if (errorMap.containsKey('email')) {
          return {
            'status': false,
            'error': errorMap['email'] ??
                'Email not found!' // Default message if null
          };
        }

        // Handle 'password' error if present
        if (errorMap.containsKey('password')) {
          return {
            'status': false,
            'error': errorMap['password'] ??
                'Incorrect password!' // Default message if null
          };
        }
      }

      // If no specific error is found, use a generic message
      return {
        'status': false,
        'error': res.error ??
            'Invalid email or password' // Fallback to generic error
      };
    }

    // Handle any other errors
    else {
      String errorMessage = "Login failed. Status code: ${response.statusCode}";
      if (response.body.isNotEmpty) {
        errorMessage += ", Body: ${response.body}";
      }
      throw Exception(errorMessage);
    }
  }

  Future<void> _saveSession(ResponseModel res) async {
    await _sessionService.saveToken(res.token ?? '');
    await _sessionService.saveUser(res.role ?? 'user');
  }
}
