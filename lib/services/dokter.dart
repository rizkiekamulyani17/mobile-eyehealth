import 'dart:convert';
import 'package:Eye_Health/models/api.dart';
import 'package:Eye_Health/models/dokter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DokterService {
  final ApiService _api = ApiService();

  Future<List<DokterModel>> fetchDokters() async {
    String baseUrl = await _api.getBaseUrl();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      var response = await http.get(
        Uri.parse("$baseUrl/api/profiledok"),
        headers: {
          'Content-Type': 'application/json',
          'X-Token': 'Bearer $token', // Include token in the headers
        },
      );
      final Map<String, dynamic> parsed = jsonDecode(response.body);
      if (parsed['success'] == true) {
        final List<dynamic> data = parsed['data'];
        return data.map((json) => DokterModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch profiles");
      }
    } catch (e) {
      throw Exception("Failed to fetch dokter: $e");
    }
  }
}
