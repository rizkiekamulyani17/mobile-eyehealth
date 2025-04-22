class DaftarPemeriksaanModel {
  final int idDokter;
  final String nama;
  final String tanggalPemeriksaan;
  final DateTime tanggalLahir;
  final String jenisKelamin;
  final String alamat;
  final String nomorHp;
  final String pekerjaan;
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

  DaftarPemeriksaanModel({
    required this.idDokter,
    required this.nama,
    required this.tanggalPemeriksaan,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.alamat,
    required this.nomorHp,
    required this.pekerjaan,
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

  Map<String, dynamic> toJson() {
    return {
      'id_dokter': idDokter,
      'nama': nama,
      'tanggal_pemeriksaan': tanggalPemeriksaan,
      'tanggal_lahir': tanggalLahir.toIso8601String(),
      'jenis_kelamin': jenisKelamin,
      'alamat': alamat,
      'nomor_hp': nomorHp,
      'pekerjaan': pekerjaan,
      'masalah_penglihatan': masalahPenglihatan,
      'menggunakan_kacamata': menggunakanKacamata,
      'riwayat_keluarga': riwayatKeluarga,
      'penjelasan_keluarga': penjelasanKeluarga,
      'penyakit_lain': penyakitLain,
      'penjelasan_penyakit': penjelasanPenyakit,
      'alergi_obat': alergiObat,
      'penjelasan_alergi': penjelasanAlergi,
      'keluhan_utama': keluhanUtama,
      'sejak_kapan': sejakKapan,
      'keluhan_perubahan': keluhanPerubahan,
      'penjelasan_keluhan': penjelasanKeluhan,
      'gejala_tambah': gejalaTambah,
      'penjelasan_gejala': penjelasanGejala,
    };
  }
}
