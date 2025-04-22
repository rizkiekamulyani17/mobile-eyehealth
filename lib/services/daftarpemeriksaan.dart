import 'dart:convert';
import 'package:Eye_Health/models/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DaftarPemeriksaan {
  // Method to register a patient
  final ApiService _api = ApiService();
  Future<void> daftar(Map<String, dynamic> patientData) async {
    String baseUrl = await _api.getBaseUrl();
    try {
      // Get token from shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found');
      }

      // Send POST request to the API
      final response = await http.post(
        Uri.parse("$baseUrl/api/daftarpasien"),
        headers: {
          'Content-Type': 'application/json',
          'X-Token':
              'Bearer $token', // Use Authorization header instead of X-Token
        },
        body: json.encode(patientData),
      );

      if (response.statusCode == 201) {
        // Successfully registered patient
        print('Patient registered successfully');
      } else {
        throw Exception('${response.body}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to register patient: $e');
    }
  }
}
