import 'dart:convert';
import 'dart:io';
import 'package:Eye_Health/models/api.dart';
import 'package:Eye_Health/models/hasil.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Deteksi {
  final ApiService _api = ApiService();

  /// Uploads an image for detection and retrieves recommendations.
  Future<Map<String, dynamic>> uploadImage({required XFile imageFile}) async {
    try {
      // Get the base URL from the ApiService
      String baseUrl = await _api.getBaseUrl();

      // Fetch the token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception("Authentication token is missing. Please log in.");
      }

      // Convert XFile to File
      File file = File(imageFile.path);

      // Check if the file exists
      if (!file.existsSync()) {
        throw Exception("The selected image file does not exist.");
      }

      // Prepare the API endpoint
      final url = Uri.parse("$baseUrl/api/deteksi");

      // Create a multipart request
      final request = http.MultipartRequest("POST", url);

      // Add authentication headers
      request.headers['X-Token'] = 'Bearer $token';

      // Attach the image file
      var image = await http.MultipartFile.fromPath('file', file.path);
      request.files.add(image);

      // Send the request
      final response = await request.send();

      // Handle response
      if (response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        final data = jsonDecode(responseBody);
        final hasil = Hasil.fromJson(data);

        // Extract the dokter_rekomendasi and obat_rekomendasi
        List<Map<String, dynamic>> dokterRekomendasi =
            List<Map<String, dynamic>>.from(data['dokter_rekomendasi'] ?? []);

        List<Map<String, dynamic>> obatRekomendasi =
            List<Map<String, dynamic>>.from(data['obat_rekomendasi'] ?? []);

        return {
          'dokter_rekomendasi': dokterRekomendasi,
          'obat_rekomendasi': obatRekomendasi,
          'detection_result': data['result']?['predicted_class'],
          'confidence': data['result']?['confidence'],
          'uploaded_image_url': data['uploaded_image'],
        };
      } else {
        // Handle non-201 responses
        final errorBody = await response.stream.bytesToString();
        throw Exception(
            "Failed to upload image. Status code: ${response.statusCode}, Error: $errorBody");
      }
    } catch (e) {
      // Handle any unexpected errors
      throw Exception("An error occurred during the image upload: $e");
    }
  }
}
