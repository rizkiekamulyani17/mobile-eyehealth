import 'dart:convert';
import 'package:Eye_Health/models/api.dart';
import 'package:Eye_Health/models/histori_pemeriksaan.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HistoriPemeriksaanService {
  final ApiService _api = ApiService();
  Future<List<RiwayatPemeriksaanModel>> fetchHistoriPemeriksaan() async {
    String baseUrl = await _api.getBaseUrl();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('$baseUrl/api/historipemeriksaan'),
      headers: {
        'Content-Type': 'application/json',
        'X-Token': 'Bearer $token', // Include token in the headers
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data
          .map((item) => RiwayatPemeriksaanModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load histori pemeriksaan');
    }
  }
}
