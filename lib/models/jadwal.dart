class JadwalModel {
  final int id;
  final int idDokter;
  final String hari;
  final String jamPraktek;
  final String lokasi;

  JadwalModel({
    required this.id,
    required this.idDokter,
    required this.hari,
    required this.jamPraktek,
    required this.lokasi,
  });

  // Deserialize JSON to JadwalModel
  factory JadwalModel.fromJson(Map<String, dynamic> json) {
    return JadwalModel(
      id: json['id'],
      idDokter: json['id_dokter'],
      hari: json['hari'],
      jamPraktek: json['jam_praktek'],
      lokasi: json['lokasi'],
    );
  }

  // Serialize JadwalModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_dokter': idDokter,
      'hari': hari,
      'jam_praktek': jamPraktek,
      'lokasi': lokasi,
    };
  }
}
