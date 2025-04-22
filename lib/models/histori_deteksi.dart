class HistoriDeteksiModel {
  final int id;
  final String predictedClass;
  final double confidence;
  final String imgDeteksi;
  final List<String> obatRekomendasi;
  final DateTime timestamp; // New field for the timestamp

  HistoriDeteksiModel({
    required this.id,
    required this.predictedClass,
    required this.confidence,
    required this.imgDeteksi,
    required this.obatRekomendasi,
    required this.timestamp,
  });

  // Factory constructor to create a HistoriDeteksiModel from JSON
  factory HistoriDeteksiModel.fromJson(Map<String, dynamic> json) {
    return HistoriDeteksiModel(
      id: json['id'],
      predictedClass: json['predicted_class'],
      confidence: json['confidence'],
      imgDeteksi: json['image_path'] ?? '',
      obatRekomendasi: List<String>.from(json['obat_rekomendasi'] ?? []),
      timestamp: DateTime.parse(json['timestamp']), // Parse the timestamp
    );
  }
}
