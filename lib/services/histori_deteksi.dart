import 'dart:convert';
import 'package:Eye_Health/models/api.dart';
import 'package:Eye_Health/models/histori_deteksi.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HistoriService {
  // Replace with your Flask API URL

  // Fetch the detection history for the user
  final ApiService _api = ApiService();
  Future<List<HistoriDeteksiModel>> fetchHistoriDeteksi() async {
    String baseUrl = await _api.getBaseUrl();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('$baseUrl/api/historideteksi'),
      headers: {
        'Content-Type': 'application/json',
        'X-Token': 'Bearer $token', // Include token in the headers
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data
      print('Response Body: ${response.body}');
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => HistoriDeteksiModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load histori deteksi');
    }
  }

  Future<void> deleteHistoriDeteksi(int id) async {
    String baseUrl = await _api.getBaseUrl();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse('$baseUrl/api/historideteksi/$id'),
      headers: {
        'Content-Type': 'application/json',
        'X-Token': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete histori deteksi');
    }
  }
}
