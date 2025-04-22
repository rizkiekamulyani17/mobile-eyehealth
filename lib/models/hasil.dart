import 'package:image_picker/image_picker.dart';

class Hasil {
  String? _hasil_deteksi;
  XFile? _gambar_mata; // Holds the image file
  String?
      _uploaded_image_url; // To store the uploaded image's URL from the server
  List<Map<String, dynamic>>? _dokter_rekomendasi =
      []; // List of recommended doctors
  List<Map<String, dynamic>>? _obat_rekomendasi =
      []; // List of recommended medicines
  String? _akurasi;

  // Custom constructor with named parameters
  Hasil({
    List<Map<String, dynamic>>? dataDokter,
    String? detectionResult,
    String? message,
    List<Map<String, dynamic>>? obatRekomendasi,
    String? uploadedImage,
  })  : _dokter_rekomendasi = dataDokter ?? [],
        _hasil_deteksi = detectionResult,
        _uploaded_image_url = uploadedImage,
        _obat_rekomendasi = obatRekomendasi ?? [],
        _akurasi = "0";

  // Getters and Setters
  String? get hasil_deteksi => _hasil_deteksi;
  XFile? get gambar_mata => _gambar_mata;
  String? get uploaded_image_url => _uploaded_image_url;
  List<Map<String, dynamic>>? get dokter_rekomendasi => _dokter_rekomendasi;
  List<Map<String, dynamic>>? get obat_rekomendasi => _obat_rekomendasi;
  String? get akurasi => _akurasi;

  set hasil_deteksi(String? hasil_deteksi) => _hasil_deteksi = hasil_deteksi;
  set gambar_mata(XFile? gambar_mata) => _gambar_mata = gambar_mata;
  set uploaded_image_url(String? url) => _uploaded_image_url = url;
  set dokter_rekomendasi(List<Map<String, dynamic>>? data) =>
      _dokter_rekomendasi = data;
  set obat_rekomendasi(List<Map<String, dynamic>>? data) =>
      _obat_rekomendasi = data;
  set akurasi(String? akurasi) => _akurasi = akurasi;

  // Factory constructor to create an instance from JSON
  factory Hasil.fromJson(Map<String, dynamic> json) {
    return Hasil(
      detectionResult: json["result"]["predicted_class"],
      uploadedImage: json["uploaded_image"],
      dataDokter: json["dokter_rekomendasi"] != null
          ? List<Map<String, dynamic>>.from(json["dokter_rekomendasi"])
          : [],
      obatRekomendasi: json["obat_rekomendasi"] != null
          ? List<Map<String, dynamic>>.from(json["obat_rekomendasi"])
          : [],
    ).._akurasi = json["result"]["confidence"]; // Parse confidence as String
  }

  // Method to convert the object to JSON for backend interaction
  Map<String, dynamic> toJson() {
    return {
      "detection_result": _hasil_deteksi,
      "uploaded_image": _gambar_mata?.path, // Save the image path if needed
      "uploaded_image_url": _uploaded_image_url,
      "dokter_rekomendasi": _dokter_rekomendasi,
      "obat_rekomendasi": _obat_rekomendasi,
      "akurasi": _akurasi,
    };
  }

  @override
  String toString() {
    return "Hasil Deteksi: $_hasil_deteksi, Image Path: ${_gambar_mata?.path}, "
        "Accuracy: $_akurasi, Data Dokter: $_dokter_rekomendasi, "
        "Obat Rekomendasi: $_obat_rekomendasi";
  }
}
