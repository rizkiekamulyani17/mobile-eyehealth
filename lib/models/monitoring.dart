import 'dart:convert';

class Pasien {
  final int id;
  final String nama;
  final String tanggalLahir;
  final String jenisKelamin;
  final String alamat;
  final String nomorHp;
  final String pekerjaan;
  final String tanggalPemeriksaan;
  final RiwayatMedis? riwayatMedis;
  final RiwayatKeluhan? riwayatKeluhan;

  Pasien({
    required this.id,
    required this.nama,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.alamat,
    required this.nomorHp,
    required this.pekerjaan,
    required this.tanggalPemeriksaan,
    this.riwayatMedis,
    this.riwayatKeluhan,
  });

  factory Pasien.fromJson(Map<String, dynamic> json) => Pasien(
        id: json['id'],
        nama: json['nama'],
        tanggalLahir: json['tanggal_lahir'],
        jenisKelamin: json['jenis_kelamin'],
        alamat: json['alamat'],
        nomorHp: json['nomor_hp'],
        pekerjaan: json['pekerjaan'],
        tanggalPemeriksaan: json['tanggal_pemeriksaan'],
        riwayatMedis: json['riwayat_medis'] != null
            ? RiwayatMedis.fromJson(json['riwayat_medis'])
            : null,
        riwayatKeluhan: json['riwayat_keluhan'] != null
            ? RiwayatKeluhan.fromJson(json['riwayat_keluhan'])
            : null,
      );
}

class RiwayatMedis {
  final String? masalahPenglihatan;
  final String? menggunakanKacamata;
  final String? riwayatKeluarga;
  final String? penjelasanKeluarga;
  final String? penyakitLain;
  final String? penjelasanPenyakit;
  final String? alergiObat;
  final String? penjelasanAlergi;

  RiwayatMedis({
    this.masalahPenglihatan,
    this.menggunakanKacamata,
    this.riwayatKeluarga,
    this.penjelasanKeluarga,
    this.penyakitLain,
    this.penjelasanPenyakit,
    this.alergiObat,
    this.penjelasanAlergi,
  });

  factory RiwayatMedis.fromJson(Map<String, dynamic> json) => RiwayatMedis(
        masalahPenglihatan: json['masalah_penglihatan'],
        menggunakanKacamata: json['menggunakan_kacamata'],
        riwayatKeluarga: json['riwayat_keluarga'],
        penjelasanKeluarga: json['penjelasan_keluarga'],
        penyakitLain: json['penyakit_lain'],
        penjelasanPenyakit: json['penjelasan_penyakit'],
        alergiObat: json['alergi_obat'],
        penjelasanAlergi: json['penjelasan_alergi'],
      );
}

class RiwayatKeluhan {
  final String? keluhanUtama;
  final String? sejakKapan;
  final String? keluhanPerubahan;
  final String? penjelasanKeluhan;
  final String? gejalaTambah;
  final String? penjelasanGejala;

  RiwayatKeluhan({
    this.keluhanUtama,
    this.sejakKapan,
    this.keluhanPerubahan,
    this.penjelasanKeluhan,
    this.gejalaTambah,
    this.penjelasanGejala,
  });

  factory RiwayatKeluhan.fromJson(Map<String, dynamic> json) => RiwayatKeluhan(
        keluhanUtama: json['keluhan_utama'],
        sejakKapan: json['sejak_kapan'],
        keluhanPerubahan: json['keluhan_perubahan'],
        penjelasanKeluhan: json['penjelasan_keluhan'],
        gejalaTambah: json['gejala_tambah'],
        penjelasanGejala: json['penjelasan_gejala'],
      );
}
