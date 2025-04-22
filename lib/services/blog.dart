import 'dart:convert';
import 'package:Eye_Health/models/api.dart';
import 'package:Eye_Health/models/blog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BlogService {
  // Fetch all articles
  final ApiService _api = ApiService();
  Future<List<Article>> fetchArticles() async {
    String baseUrl = await _api.getBaseUrl();
    print("$baseUrl/api/blog");
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/api/blog"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final blogModel = BlogModel.fromJson(data);
        return blogModel.articles;
      } else {
        throw Exception("Failed to fetch articles: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching articles: $e");
      return []; // Return an empty list in case of an error
    }
  }

  // Fetch a single article by ID
  Future<Article> fetchArticleById(String id) async {
    try {
      String baseUrl = await _api.getBaseUrl();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse("$baseUrl/api/article/$id"),
        headers: {
          'Content-Type': 'application/json',
          'X-Token': 'Bearer $token', // Include token in the headers
        },
      );

      // Check for successful response
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        BlogModel blogModel = BlogModel.fromJson(jsonData);
        if (blogModel.articles.isNotEmpty) {
          return blogModel.articles
              .first; // Return the first article (since API returns one)
        } else {
          throw Exception("No article found with the given ID");
        }
      } else {
        throw Exception(
            "Failed to load article details: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error fetching article: $error");
    }
  }
}
