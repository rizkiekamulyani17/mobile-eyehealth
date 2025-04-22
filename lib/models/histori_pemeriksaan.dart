class RiwayatPemeriksaanModel {
  final String nama;
  final String jenisKelamin;
  final String alamat;
  final String nomorHp;
  final String pekerjaan;
  final String tanggalPemeriksaan;

  // Combine the fields from RiwayatMedis and RiwayatKeluhan
  final String masalahPenglihatan;
  final String menggunakanKacamata;
  final String riwayatKeluarga;
  final String penjelasanKeluarga;
  final String penyakitLain;
  final String penjelasanPenyakit;
  final String alergiObat;
  final String penjelasanAlergi;

  final String keluhanUtama;
  final String sejakKapan;
  final String keluhanPerubahan;
  final String penjelasanKeluhan;
  final String gejalaTambah;
  final String penjelasanGejala;

  RiwayatPemeriksaanModel({
    required this.nama,
    required this.jenisKelamin,
    required this.alamat,
    required this.nomorHp,
    required this.pekerjaan,
    required this.tanggalPemeriksaan,

    // Include the merged fields
    required this.masalahPenglihatan,
    required this.menggunakanKacamata,
    required this.riwayatKeluarga,
    required this.penjelasanKeluarga,
    required this.penyakitLain,
    required this.penjelasanPenyakit,
    required this.alergiObat,
    required this.penjelasanAlergi,
    required this.keluhanUtama,
    required this.sejakKapan,
    required this.keluhanPerubahan,
    required this.penjelasanKeluhan,
    required this.gejalaTambah,
    required this.penjelasanGejala,
  });

  factory RiwayatPemeriksaanModel.fromJson(Map<String, dynamic> json) {
    return RiwayatPemeriksaanModel(
      // Parsing the pasien data
      nama: json['pasien']['nama'] ?? '',
      jenisKelamin: json['pasien']['jenis_kelamin'] ?? '',
      alamat: json['pasien']['alamat'] ?? '',
      nomorHp: json['pasien']['nomor_hp'] ?? '',
      pekerjaan: json['pasien']['pekerjaan'] ?? '',
      tanggalPemeriksaan: json['pasien']['tanggal_pemeriksaan'] ?? '',

      // Parsing riwayat_medis - since it's an array, get the first element (or empty if absent)
      masalahPenglihatan: json['riwayat_medis']?.isNotEmpty == true
          ? json['riwayat_medis'][0]['masalah_penglihatan'] ?? ''
          : '',
      menggunakanKacamata: json['riwayat_medis']?.isNotEmpty == true
          ? json['riwayat_medis'][0]['menggunakan_kacamata'] ?? ''
          : '',
      riwayatKeluarga: json['riwayat_medis']?.isNotEmpty == true
          ? json['riwayat_medis'][0]['riwayat_keluarga'] ?? ''
          : '',
      penjelasanKeluarga: json['riwayat_medis']?.isNotEmpty == true
          ? json['riwayat_medis'][0]['penjelasan_keluarga'] ?? ''
          : '',
      penyakitLain: json['riwayat_medis']?.isNotEmpty == true
          ? json['riwayat_medis'][0]['penyakit_lain'] ?? ''
          : '',
      penjelasanPenyakit: json['riwayat_medis']?.isNotEmpty == true
          ? json['riwayat_medis'][0]['penjelasan_penyakit'] ?? ''
          : '',
      alergiObat: json['riwayat_medis']?.isNotEmpty == true
          ? json['riwayat_medis'][0]['alergi_obat'] ?? ''
          : '',
      penjelasanAlergi: json['riwayat_medis']?.isNotEmpty == true
          ? json['riwayat_medis'][0]['penjelasan_alergi'] ?? ''
          : '',

      // Parsing riwayat_keluhan - since it's an array, get the first element (or empty if absent)
      keluhanUtama: json['riwayat_keluhan']?.isNotEmpty == true
          ? json['riwayat_keluhan'][0]['keluhan_utama'] ?? ''
          : '',
      sejakKapan: json['riwayat_keluhan']?.isNotEmpty == true
          ? json['riwayat_keluhan'][0]['sejak_kapan'] ?? ''
          : '',
      keluhanPerubahan: json['riwayat_keluhan']?.isNotEmpty == true
          ? json['riwayat_keluhan'][0]['keluhan_perubahan'] ?? ''
          : '',
      penjelasanKeluhan: json['riwayat_keluhan']?.isNotEmpty == true
          ? json['riwayat_keluhan'][0]['penjelasan_keluhan'] ?? ''
          : '',
      gejalaTambah: json['riwayat_keluhan']?.isNotEmpty == true
          ? json['riwayat_keluhan'][0]['gejala_tambah'] ?? ''
          : '',
      penjelasanGejala: json['riwayat_keluhan']?.isNotEmpty == true
          ? json['riwayat_keluhan'][0]['penjelasan_gejala'] ?? ''
          : '',
    );
  }
}
