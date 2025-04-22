import 'dart:convert';
import 'package:Eye_Health/models/api.dart';
import 'package:Eye_Health/models/monitoring.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final ApiService _api = ApiService();

class MonitoringService {
  Future<List<Pasien>> fetchMonitoringData(
      {String? search, String? date}) async {
    String baseUrl = await _api.getBaseUrl();
    print("$baseUrl/api/monitoring");

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      // Construct the API URL with optional search and date parameters
      String url = "$baseUrl/api/monitoring";
      if (search != null || date != null) {
        url += "?";
        if (search != null) url += "search=$search&";
        if (date != null) url += "date=$date";
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'X-Token': 'Bearer $token', // Include the token in the headers
        },
      );

      if (response.statusCode == 200) {
        final data =
            jsonDecode(response.body) as List; // Parse response as a list
        return data
            .map((json) => Pasien.fromJson(json))
            .toList(); // Map JSON to Pasien model
      } else {
        throw Exception(
            "Failed to fetch monitoring data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching monitoring data: $e");
      return []; // Return an empty list in case of an error
    }
  }
}
