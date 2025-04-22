import 'dart:convert';
import 'package:Eye_Health/models/api.dart';
import 'package:http/http.dart' as http;

class ChatbotService {
  final ApiService _api = ApiService();
  Future<String> getBotReply(String userMessage) async {
    String baseUrl = await _api.getBaseUrl();
    print("$baseUrl/api/chatbot");
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/chatbot"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': userMessage}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['reply'];
      } else {
        throw Exception('Failed to get bot response');
      }
    } catch (e) {
      throw Exception('Error during API request: $e');
    }
  }
}
