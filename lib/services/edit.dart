import 'dart:convert';
import 'dart:io';
import 'package:Eye_Health/models/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserEditService {
  final ApiService _api = ApiService();

  /// Method to update the user profile, including optional file upload for profile picture
  Future<void> updateUserProfile(Map<String, dynamic> updatedData,
      {File? profilePicture}) async {
      String baseUrl = await _api.getBaseUrl();
    try {
      // Get the saved token
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception("Authentication token is missing");
      }

      // Prepare the request
      var uri = Uri.parse('$baseUrl/api/user-details');
      var request = http.MultipartRequest('PUT', uri)
        ..headers.addAll({
          'X-Token': 'Bearer $token', // Add your token header
        });

      // Add JSON fields to the request
      updatedData.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Add the profile picture file, if provided
      if (profilePicture != null) {
        var pictureStream = http.ByteStream(profilePicture.openRead());
        var pictureLength = await profilePicture.length();

        request.files.add(http.MultipartFile(
          'profile_picture', // Key used in the backend for the file
          pictureStream,
          pictureLength,
          filename: profilePicture.path.split('/').last,
        ));
      }

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        // Success response
        return;
      } else {
        // Get the error response body
        var responseBody = await response.stream.bytesToString();
        throw Exception(
            'Failed to update profile: ${jsonDecode(responseBody)['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Error updating profile: $e');
    }
  }
}
