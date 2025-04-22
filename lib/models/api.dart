import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  String _baseUrl =
      'https://2013-2404-8000-1013-36-f183-f8fa-6870-f6d8.ngrok-free.app/'; // Default base URL
  final String _header = "{'Content-Type': 'application/json'}";

  ApiService() {
    _loadBaseUrl(); // Load the saved base URL (if exists) when the service is initialized
  }

  String get header => _header;

  set baseUrl(String url) {
    _baseUrl = url;
    _saveBaseUrl(url); // Save the new base URL for persistence
  }

  // Save the base URL in SharedPreferences
  Future<void> _saveBaseUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('baseUrl', url);
  }

  // Load the base URL from SharedPreferences
  Future<void> _loadBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUrl = prefs.getString('baseUrl');
    if (savedUrl != null) {
      _baseUrl = savedUrl;
    }
  }

  // Asynchronous method to get the base URL
  Future<String> getBaseUrl() async {
    // Ensure the base URL is loaded from SharedPreferences
    await _loadBaseUrl();
    return _baseUrl;
  }
}
