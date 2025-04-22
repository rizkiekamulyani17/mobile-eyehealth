import 'dart:convert';
import 'package:Eye_Health/models/api.dart';
import 'package:http/http.dart' as http;

class SentimentService {
  final ApiService _api = ApiService();

  Future<String> postKomentar(String userNama, String userKomentar) async {
    try {
      String baseUrl = await _api.getBaseUrl();
      final response = await http.post(
        // Replace with the correct API endpoint URL
        Uri.parse("$baseUrl/api/add_review"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nama': userNama, 'komentar': userKomentar}),
      );

      // Log the response status and body for debugging
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // Handle both 200 and 201 status codes
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data
            .toString(); // You can modify this based on your API's response format
      } else {
        throw Exception('Failed to post comment');
      }
    } catch (e) {
      print("Error during API request: $e");
      throw Exception('Error during API request: $e');
    }
  }
}
