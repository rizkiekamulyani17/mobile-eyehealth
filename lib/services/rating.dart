import 'dart:convert';
import 'package:Eye_Health/models/api.dart';
import 'package:Eye_Health/models/rating.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RatingService {
  final ApiService _api = ApiService();
  Future<RatingResult> getRatingData() async {
    try {
      String baseUrl = await _api.getBaseUrl();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await http.get(
        Uri.parse("$baseUrl/api/sentiment"),
        headers: {
          'Content-Type': 'application/json',
          'X-Token': 'Bearer $token', // Include token in the headers
        },
      );
      if (response.statusCode == 200) {
        return RatingResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load sentiment data');
      }
    } catch (e) {
      throw Exception('Error fetching sentiment data: $e');
    }
  }
}
