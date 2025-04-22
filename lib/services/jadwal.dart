import 'dart:convert';
import 'package:Eye_Health/models/api.dart';
import 'package:Eye_Health/models/jadwal.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JadwalService {
  final ApiService _api = ApiService(); // Replace with your actual base URL

  // Fetch doctor schedules
  Future<List<JadwalModel>> getJadwalByDoctorId(int doctorId) async {
    try {
      // Get token from shared preferences
      String baseUrl = await _api.getBaseUrl();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.get(
        Uri.parse("$baseUrl/api/jadwaldokter/$doctorId"),
        headers: {
          'Content-Type': 'application/json',
          'X-Token': 'Bearer $token', // Include token in the headers
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // Deserialize the `jadwal` list
        List<dynamic> jadwalList = data['jadwal'];
        return jadwalList.map((item) => JadwalModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load schedules: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load schedules: $e');
    }
  }
}
